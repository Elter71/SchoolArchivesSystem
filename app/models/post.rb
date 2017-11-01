class Post < ApplicationRecord
  validates :title, :description, presence: true
  belongs_to :user
  require 'net/ftp'


  def save_files(files)
    if files
      create_ftp_session {|ftp| create_resources(ftp, files)}
    end
  end

  def thumbnail
    path = "#{Rails.root}/public/ftp/#{self.id}.jpg"
    get_resources(path)
  end

  private

  def create_ftp_session
    Net::FTP.open('192.168.0.105', 'ftpp', 'admin') do |ftp|
      ftp.passive = true
      yield ftp
    end
  end

  def create_resources(ftp, files)
    ftp.mkdir(id)
    ftp.chdir(id)
    save_files_in_ftp(ftp, files)
  end

  def save_files_in_ftp(ftp, files)
    files.each do |file|
      ftp.putbinaryfile(file.tempfile, File.basename(file.original_filename))
    end
  end

  def get_resources(path)
    unless File.read(path)
      create_ftp_session {|ftp| resources_from_ftp(ftp, path)}
    end
    path.remove "#{Rails.root}/public/"
  end

  def resources_from_ftp(ftp, save_path)
    ftp.chdir(id)
    list = ftp.nlst('*.jpg') | ftp.nlst('*.png')
    list.each do |file|
      return ftp.getbinaryfile(file, save_path)
    end
  end


end
