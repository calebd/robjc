require 'robjc/resources/resource'
require 'tempfile'
require 'plist'

class Resources::StringResource < Resources::Resource
  attr_reader :strings

  def strings
    @strings ||= read_strings_file
  end

  def method_name string
    components = string.split "_"
    [components.shift.downcase, *components.map(&:capitalize)].join
  end

  private

  def read_strings_file
    keys = []
    Tempfile.create('strings.plist') do |f|
      `plutil -convert xml1 "#{path}" -o "#{f.path}"`
      keys = Plist::parse_xml(f.path).keys
    end
    keys.uniq
  end

end
