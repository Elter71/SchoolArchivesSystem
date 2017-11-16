require 'active_interaction'
class CreateZipFiles < ActiveInteraction::Base
  attr_reader :zip_stream
  integer :id
  validates :id, presence: true

  def execute
    if Post.find_by_id(@id)
      create_zip_stream
      @zip_stream.rewind
    else
      add_errors
    end
  end

  def zip_name
    "#{@id}.zip"
  end

  private

  def create_zip_stream
    @zip_stream = Zip::OutputStream.write_buffer do |stream|
      put_files_into_zip_file(stream)
    end
  end

  def put_files_into_zip_file(stream)
    Dir.glob(Configuration.instance.server_path + @id.to_s + '/*').select do |file_path|
      stream.put_next_entry(file_name(file_path))
      stream.write file_stream(file_path)
    end
  end

  def file_name(file_path)
    File.basename(file_path)
  end

  def file_stream(file_path)
    File.open(file_path).read
  end

  def add_errors
    errors.add(:post, 'does not exist')
  end
end
