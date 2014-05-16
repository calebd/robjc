require 'robjc/resources/string_resource'
require 'robjc/resources/asset_catalog_resource'

module Resources
  class Reader

    attr_reader :target

    def initialize(target)
      @target = target
    end

    def resources
      @resources ||= {
        images: images,
        strings: strings,
        nibs: nibs,
        storyboards: storyboards,
        asset_catalogs: asset_catalogs,
        json_files: json_files
        plists: plists
      }
    end

    def self.projects
      Dir.glob('*.xcodeproj').map do |f|
        Xcodeproj::Project.open(f)
      end
    end

    def self.targets
      projects.map(&:targets).flatten.select do |t|
        t.is_a? Xcodeproj::Project::Object::PBXNativeTarget
      end
    end

    def files
      @files ||= target.build_phases.map(&:files).flatten.map do |file|
        file.file_ref.real_path.to_s
      end
    end

    private

    def images
      files.reject{ |f| f.match(/\.xcassets/i) }.grep(/\.png$/i)
    end

    def strings
      files.grep(/\.strings$/i).map do |f|
        Resources::StringResource.new(f)
      end
    end

    def nibs
      files.grep(/\.nib$/)
      end
    end

    def storyboards
      files.grep(/\.storyboard$/i)
    end

    def asset_catalogs
      files.grep(/.xcassets$/i).map do |f|
        Resources::AssetCatalogResource.new(f)
      end
    end

    def json_files
      files.grep(/\.json$/i)
    end

    def plists
      files.grep(/\.plist$/i)
    end

  end
end
