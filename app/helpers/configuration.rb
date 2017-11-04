class Configuration
  attr_reader :ftp_server, :ftp_user, :ftp_user_password, :server_path

  def initialize
    @ftp_server = 'localhost'
    @ftp_user = 'ftpp'
    @ftp_user_password = 'admin'
    @server_path = '/home/ftpp/ftp'
  end

  @@instance = Configuration.new

  def self.instance
    @@instance
  end

  private_class_method :new
end
