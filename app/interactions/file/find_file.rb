require 'active_interaction'
class FindFile < ActiveInteraction::Base
  attr_reader :file
  integer :id
  string :file_name
  validates :id, :file_name, presence: true

  def execute
    Dir.glob(Configuration.instance.server_path + @id.to_s + "/#{@file_name}.*").select do |file_path|
      @file = read_file(file_path)
    end
    check_is_error
  end

  def file_name_with_type
    @file_name + @file_type
  end

  private

  def read_file(file_path)
    if File.file? file_path
      @file_type = File.extname(file_path)
      File.open(file_path)
    end
  end

  def check_is_error
    errors.add(:post_file, 'does not exist') unless @file
  end

end
