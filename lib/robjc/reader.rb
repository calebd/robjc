module Resource
  class Reader

    def init(target)
      @target = target
    end

    # def self.select_files
    #   Dir.glob('**/*').select do |f|
    #     false if f.match /^Pods/
    #     false if f.match /\.bundle/
    #     yield f
    #   end
    # end

    # def self.images
    #   select_files do |f|
    #     f.match /\.png$/
    #   end
    # end

    # def self.strings
    #   select_files do |f|
    #     f.match /\.strings$/
    #   end
    # end

    # def self.nibs
    #   select_files do |f|
    #     f.match /\.xib$/
    #   end
    # end

    # def self.storyboards
    #   select_files do |f|
    #     f.match /\.storyboard$/
    #   end
    # end

  end
end
