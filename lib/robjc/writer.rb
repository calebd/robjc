require 'erb'
require 'xcodeproj'

module Resources
  class Writer

    attr_reader :generated_at
    attr_reader :resources

    def initialize(resources)
      @resources = resources
    end

    def write
      @generated_at = Time.now
      ensure_directory
      write_resources_class
      write_images_class
      write_strings_class
    end

    def add_to_target(target)
      references = [ header_file_reference, implementation_file_reference ]
      target.add_file_references
    end

    def class_prefix
      @class_prefix ||= if project
        project.root_object.attributes['CLASSPREFIX']
      else
        'CMD'
      end
    end

    private

    def project
      return @project if @project
      path = Dir.glob('*.xcodeproj').first
      @project = path ? Xcodeproj::Project.open(path) : nil
    end

    def write_resources_class
      render_template_for_class 'resources', 'CMDResources'
    end

    def write_images_class
      render_template_for_class 'image_resources', 'CMDImageResources'
    end

    def write_strings_class
      render_template_for_class 'string_resources', 'CMDStringResources'
    end

    def render_template_for_class(template, klass)
      [ "h", "m" ].each do |e|
        render_template_to_file "#{template}.#{e}", "#{klass}.#{e}"
      end
    end

    def render_template_to_file(template, file)
      File.open(File.join(directory_path, file), 'w') do |f|
        result = erb template
        f.write(result)
      end
    end

    def directory_path
      'Resources/CMDResources'
    end

    def ensure_directory
      `mkdir -p #{directory_path}`
    end

    def erb(template)
      template_path = File.expand_path("../../../data/views/#{template}.erb", __FILE__)
      template = ERB.new(File.read(template_path), nil, nil)
      template.result(binding)
    end

  end
end
