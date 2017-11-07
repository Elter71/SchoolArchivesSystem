require 'active_interaction'
class FindFile < ActiveInteraction::Base
  attr_reader :file
  integer :id
  string :file_name
  validates :id, :file_name, presence: true

  def execute
    Dir.glob(Configuration.instance.server_path + @id.to_s + "/#{@file_name}.*").select do |file|
      @file = read_file(file)
    end
    check_is_error
  end

  def file_name_with_type
    @file_name + @file_type
  end

  private

  def read_file(file)
    if File.file? file
      @file_type = File.extname(file)
      File.open(file)
    end
  end

  def check_is_error
    unless @file
      errors.add(:post_file, 'does not exist')
    end
  end

end
