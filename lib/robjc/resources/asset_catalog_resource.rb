require 'robjc/resources/resource'

class Resources::AssetCatalogResource < Resources::Resource
  attr_reader :images

  IMAGE_SET_EXTENSION = "imageset"

  def images
    @images ||= image_names
  end

    def method_name(string)
    components = string.split('-')
    string = components.first.downcase
    if components.length == 1
      string
    else
      components.each_with_index do |s, i|
        next if i == 0
        string += s.capitalize
      end
    end
    string
  end

  private

  def image_names
    image_sets.map do |f|
      File.basename(f, ".#{IMAGE_SET_EXTENSION}")
    end
  end

  def image_sets
    Dir.glob(File.join(path, "*.#{IMAGE_SET_EXTENSION}"))
  end

end
