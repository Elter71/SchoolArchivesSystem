module HomeHelper
  def get_thumbnail(post)
    root_url+"file/#{post.id}/#{post.thumbnail}"
  end
end
