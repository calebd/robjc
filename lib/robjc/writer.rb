module Resource
  class Writer

    def initialize

    end

    def write
      write_header
      write_implementation
    end

    def add_to_target(target)
      references = [ header_file_reference, implementation_file_reference ]
      target.add_file_references
    end

    private

    def write_header
      File.open(header_path, 'w') do |f|
        template = ERB.new File.read('data/resource_manager.h.erb'), nil, nil
#         string = <<-EOL
# //
# // R.h
# // Automatically generated on #{Time.new.to_s}
# //

# #define R

# @interface CMDResourceManager : NSObject

# + (void)image;
# + (void)string;

# @end
# EOL
        f.write(template.render)
      end
    end

    def write_implementation
      File.open(implementation_path, 'w') do |f|
        string = <<-EOL
//
// R.m
// Automatically generated on #{Time.new.to_s}
//

@implementation CMDResourceManager

+ (void)image {

}

+ (void)string {

}

@end
EOL
        f.write(string)
      end
    end

    def directory_path
      'Resources'
    end

    def header_name
      'CMDResourceManager.h'
    end

    def header_path
      "#{directory_path}/#{header_name}"
    end

    def header_file_reference
      reference = Xcodeproj::Project::Object::PBXFileReference.new
      reference.path = header_path
      reference.name = header_name
      reference
    end

    def implementation_name
      'CMDResourceManager.m'
    end

    def implementation_path
      "#{directory_path}/#{implementation_name}"
    end

    def implementation_file_reference
      reference = Xcodeproj::Project::Object::PBXFileReference.new
      reference.path = implementation_path
      reference.name = implementation_name
      reference
    end

    def ensure_directory
      Dir.mkdir(directory_path) unless Dir.exists?(directory_path)
    end

  end
end
