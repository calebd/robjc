require 'robjc/resources/string_resource'
require 'robjc/resources/asset_catalog_resource'

module Resources
  class Reader

    def resources
      @resources ||= {
        images: images,
        strings: strings,
        nibs: nibs,
        storyboards: storyboards,
        asset_catalogs: asset_catalogs
      }
    end

    private

    def files
      @files ||= Dir.glob('**/*').select do |f|
        next false if f.match /^pods/i
        next false if f.match /^vendor/i
        next false if f.match /\.bundle/i
        true
      end
    end

    def images
      @images ||= files.select do |f|
        next false if f.match /\.xcassets/i
        f.match /\.png$/i
      end
    end

    def strings
      @strings ||= files.select do |f|
        f.match /\.strings$/i
      end.map do |f|
        Resources::StringResource.new(f)
      end
    end

    def nibs
      @nibs ||= files.select do |f|
        f.match /\.nib$/
      end
    end

    def storyboards
      @storyboards ||= files.select do |f|
        f.match /\.storyboard$/i
      end
    end

    def asset_catalogs
      @asset_catalogs ||= files.select do |f|
        f.match /.xcassets$/i
      end.map do |f|
        Resources::AssetCatalogResource.new(f)
      end
    end

  end
end
