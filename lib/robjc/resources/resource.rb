class Resources::Resource

  attr_reader :path

  def initialize(path)
    @path = File.expand_path(path)
  end

  def method_name(string)
    return string
  end

end
