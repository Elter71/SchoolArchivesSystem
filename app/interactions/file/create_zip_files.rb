require 'active_interaction'
class CreateZipFiles < ActiveInteraction::Base
  attr_reader :zip_stream
  integer :id
  validates :id, presence: true

  def execute
    @zip_stream = Zip::OutputStream.write_buffer do |stream|
      put_files_into_zip_file(stream)
    end
    @zip_stream.rewind
    check_is_error
  end

  def zip_name
    "#{@id}.zip"
  end

  private

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


  def check_is_error
    errors.add(:post_file, 'does not exist') unless @zip_stream
  end

end