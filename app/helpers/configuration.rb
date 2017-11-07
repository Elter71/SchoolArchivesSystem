class Configuration
  attr_reader :server_path

  def initialize
    @server_path = "#{Rails.root}/server/ftp/"
  end

  @@instance = Configuration.new

  def self.instance
    @@instance
  end

  private_class_method :new
end
