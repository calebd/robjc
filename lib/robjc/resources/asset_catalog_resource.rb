require 'robjc/resources/resource'

class Resources::AssetCatalogesource < Resources::Resource
  attr_reader :images

  def images
    @images ||= image_names
  end

  private

  def image_names
    Dir.glob(File.join(path, "*.imageset"))
  end

  def read_strings_file
    # contents = File.read(path)
    # lines = contents.split('\n')
    # pairs = {}
    # lines.each do |l|
    #   key = lines.match(/^"([^"]+)"/)[1]
    #   value = lines.match(//)[1]
    #   pairs[key] = value
    # end
    {}
  end

end
