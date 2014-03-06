require 'robjc/resources/resource'
require 'tmpfile'
require 'plist'

class Resources::StringResource < Resources::Resource
  attr_reader :pairs

  def pairs
    @pairs ||= read_strings_file
  end

  private

  def read_strings_file
    hash = {}
    Tempfile.create('strings.plist') do |f|
      `plutil -convert xml1 "#{path}" -o f.path`
      hash = Plist::parse_xml(f.path)
    end
    hash
  end

end
