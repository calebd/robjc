require 'robjc/resources/resource'

class Resources::StringResource < Resources::Resource
  attr_reader :pairs

  def init(path)
    super
  end

  def pairs
    @pairs ||= read_strings_file
  end

  private

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
