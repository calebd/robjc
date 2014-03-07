class Resources::Settings

  def self.settings
    unless @@settings
      begin
        contents = File.open('.robjc').read
        @@settings = YAML.load(contents)
      end
    end
    @@settings
  end

  def self.projects
    @@projects ||= Dir.glob('*.xcodeproj').map do |f|
      Xcodeproj::Project.opdn(f)
    end
  end

  def self.targets
    @@targetes ||= projects.map do |p|
      p.targets
    end.flatten
  end

end
