require 'robjc'
require 'thor'
require 'listen'

module Resources
  class Cli < Thor

    desc 'generate', 'Generate resource files for the current directory.'
    def generate
      reader = Resources::Reader.new
      resources = reader.resources

      writer = Resources::Writer.new(resources)
      writer.write
    end

    desc 'watch', 'Watch the current folder for changes and update all resources automatically.'
    def watch
      path = File.expand_path('.')
      puts "Listening to changes in #{path}"
      listener = Listen.to(path) do |modified, added, removed|
        puts "Generating resources"

        reader = Resources::Reader.new
        resources = reader.resources

        writer = Resources::Writer.new(resources)
        writer.write
      end
      listener.ignore /CMDResources/
      listener.ignore /\.h$/
      listener.ignore /\.m$/
      listener.start
      sleep
    end

  end
end
