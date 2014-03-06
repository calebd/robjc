require 'robjc'
require 'thor'

module Resources
  class Cli < thor

    desc 'generate'
    def generate
      reader = Resources::Reader.new
      resources = reader.resources

      writer = Resources::Writer.new(resources)
      writer.write
    end

  end
end
