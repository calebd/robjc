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
      projects.map do |p|
        p.targets
      end.flatten.select do |t|
        t.is_a? Xcodeproj::Project::Object::PBXNativeTarget
      end
    end

    def files
      @files ||= target.build_phases.map do |phase|
        phase.files
      end.flatten.map do |file|
        file.file_ref.real_path.to_s
      end
    end

    private

    def images
      files.select do |f|
        next false if f.match /\.xcassets/i
        f.match /\.png$/i
      end
    end

    def strings
      files.select do |f|
        f.match /\.strings$/i
      end.map do |f|
        Resources::StringResource.new(f)
      end
    end

    def nibs
      files.select do |f|
        f.match /\.nib$/
      end
    end

    def storyboards
      files.select do |f|
        f.match /\.storyboard$/i
      end
    end

    def asset_catalogs
      files.select do |f|
        f.match /.xcassets$/i
      end.map do |f|
        Resources::AssetCatalogResource.new(f)
      end
    end

    def json_files
      files.select do |f|
        f.match /\.json$/i
      end
    end

    def plists
      files.select do |f|
        f.match /\.plist$/i
      end
    end

  end
end
