require 'erb'

module Resource
  class Writer

    def initialize

    end

    def write
      @date = Time.now
      write_resources_class
    end

    def add_to_target(target)
      references = [ header_file_reference, implementation_file_reference ]
      target.add_file_references
    end

    private

    def write_resources_class
      context = { generated_at: @date }
      File.open(File.join(directory_path, 'Resources/CMDResources.h'), 'w') do |f|
        result = erb 'resources.h', context
        f.write(result)
      end
      File.open(File.join(directory_path, 'Resources/CMDResources.m'), 'w') do |f|
        result = erb 'resources.m', context
        f.write(result)
      end
    end

    def directory_path
      'Resources/CMDResources'
    end

    def ensure_directory
      `mkdir -p #{directory_path}`
    end

    def erb(template, hash = {})
      template_path = File.expand_path("../../../data/views/#{template}.erb", __FILE__)
      template = ERB.new(File.read(template_path), nil, nil)
      context = ERBContext.new(hash)
      template.result(context)
    end

    # def write_header
    #   File.open(header_path, 'w') do |f|
    #     template = ERB.new File.read(File.expand_path('../../../data/views/resources.h.erb', __FILE__)), nil, nil
    #     f.write(template.result)
    #   end
    # end

    # def write_implementation
    #   File.open(implementation_path, 'w') do |f|
    #     template = ERB.new File.read(File.expand_path('../../../data/views/resources.m.erb', __FILE__)), nil, nil
    #     f.write(template.result)
    #   end
    # end

    # def directory_path
    #   'Resources/CMDResources'
    # end

    # def header_name
    #   'CMDResourceManager.h'
    # end

    # def header_path
    #   "#{directory_path}/#{header_name}"
    # end

    # def header_file_reference
    #   reference = Xcodeproj::Project::Object::PBXFileReference.new
    #   reference.path = header_path
    #   reference.name = header_name
    #   reference
    # end

    # def implementation_name
    #   'CMDResourceManager.m'
    # end

    # def implementation_path
    #   "#{directory_path}/#{implementation_name}"
    # end

    # def implementation_file_reference
    #   reference = Xcodeproj::Project::Object::PBXFileReference.new
    #   reference.path = implementation_path
    #   reference.name = implementation_name
    #   reference
    # end

    # def ensure_directory
    #   Dir.mkdir(directory_path) unless Dir.exists?(directory_path)
    # end

  end
end
