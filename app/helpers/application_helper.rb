module ApplicationHelper

  # @return [Configuration]
  def config
    Configuration.instance
  end

  def is_active(path)
    if request.path == path
      'active'
    else
      ''
    end
  end

end
