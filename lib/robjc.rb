require "xcodeproj"
require "robjc/version"
# require "robjc/reader"

module Resource

  def self.read

    # Load project
    project_path = Dir.glob('*.xcodeproj').first
    project = Xcodeproj::Project.new(project_path)
    project.initialize_from_file

    # Load target
    target = project.targets.first
    phase = target.resources_build_phase
    puts phase.files

    # Create reader
    # reader = Resource::Reader.new(target)


  end

end
