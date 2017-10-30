class AdminFilter
  def self.before(controller)
    if controller.current_user.role.id != Role.find_by_name('admin').id
      controller.redirect_to(controller.root_url) && (return false)
    end
  end
end