class Resources::Settings
  include Singleton

  private

  def definitions
    @definitions ||= []
  end

  def begin_project(name)
    @current_project = { name: name, targets: [] }
    definitions << @current_project
  end

  def end_project(name)
    @current_project = nil
  end

  def begin_target(name)
    @current_target = { name: name, resources: [], transformers: {} }
    @current_project[:targets] << @current_target
    class_prefix
  end

  def end_target(name)
    @current_target = nil
  end

  def project(name)
    begin_project(name)
    yield
    end_project(name)
  end

  def target(name)
    begin_target(name)
    yield
    end_target(name)
  end

  def resources(*symbols)
    if symbols.count > 0
      @current_target[:resources] += symbols
    end
  end

  def strings(*symbols, &block)
    if symbols.count == 0
      @current_target[:transformers][:all] = block
    else
      symbols.each do |s|
        @current_target[:transformers][s] = block
      end
    end
  end

  def class_prefix(prefix = 'CMD')
    @current_target[:class_prefix] = prefix
  end

  self.instance.instance_eval(File.open('.robjc').read)

end
