require 'xcodeproj'
require 'robjc/version'
require 'robjc/reader'
require 'robjc/writer'

module Resource

  def self.read

    # Load project
    project_path = Dir.glob('*.xcodeproj').first
    project = Xcodeproj::Project.new(project_path)
    project.initialize_from_file

    # Load target
    target = project.targets.first
    phase = target.resources_build_phase
    phase.files_references.each do |f|
        puts "----------"
        puts f.class
        puts f.last_known_file_type
        # puts f.name
        # puts f.explicit_file_type
    end

    # Create reader
    # reader = Resource::Reader.new(target)

    # Create writer
    writer = Resource::Writer.new
    writer.write
    # writer.add_to_target(target)
  end

end
