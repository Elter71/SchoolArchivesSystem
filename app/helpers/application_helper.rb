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

  def stylesheet_tag(controller)
    with_out_controller = %w(devise/sessions devise/passwords)
    render = true
    with_out_controller.each do |with_out|
      render = false if controller == with_out
    end
    stylesheet_link_tag controller if render
  end

end
