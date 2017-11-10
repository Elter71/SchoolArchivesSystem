require 'active_interaction'
class FindGalleryFiles < ActiveInteraction::Base
  integer :id
  attr_reader :files_name
  validates :id, presence: true

  def execute
    @files_name = []
    Dir.glob(Configuration.instance.server_path + @id.to_s + '/*').select do |file_path|
      read_file_name(file_path)
    end
    check_is_error
  end

  private

  def check_is_error
    errors.add(:post_file, 'does not exist') if @files_name.empty?
  end

  def read_file_name(file_path)
    if File.file? file_path
      if_image(file_path)
    end
  end

  def if_image(file_path)
    if File.extname(file_path).match Configuration.instance.image_format
      file_name = File.basename(file_path)
      @files_name.push(file_name)
    end
  end
end
