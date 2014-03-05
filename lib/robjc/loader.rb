module Resource
  class Loader

    def self.all_files
      Dir.glob('**/*')
    end

    def self.images
      all_files.select do |f|
        return false if f.matches /^Pods/
        return false if f.matches /\.bundle/
        return true
      end
    end

  end
end
