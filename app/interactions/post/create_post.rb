require 'active_interaction'
class CreatePost < ActiveInteraction::Base
  integer :user_id
  string :title, :description, :tag
  array :files, default: []
  validates :user_id, :title, :description, presence: true

  def execute
    post = Post.new(create_post_parameter)
    if post.save
      save_file(post)
    else
      errors.merge!(post.errors)
    end
    post
  end

  private

  def create_post_parameter
    parameter = inputs
    parameter.delete(:files)
    parameter[:thumbnail] = find_thumbnail
    parameter
  end

  def find_thumbnail
    @files.each do |file|
      return file.original_filename if file.content_type.include? 'image'
    end
    ''
  end

  def save_file(post)
    path = create_post_dir(post)
    @files.each do |file|
      File.open(path + "/#{file.original_filename}", 'wb') {|f| f.write file.read}
    end
  end

  def create_post_dir(post)
    path = Configuration.instance.server_path + post.id.to_s
    Dir.mkdir(path)
    path
  end
end
