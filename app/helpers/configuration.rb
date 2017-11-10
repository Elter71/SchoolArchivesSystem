class Configuration
  attr_reader :server_path, :image_format

  def initialize
    @server_path = "#{Rails.root}/server/ftp/"
    @image_format = /.raw|.png|.jpg/
  end

  @@instance = Configuration.new

  def self.instance
    @@instance
  end

  private_class_method :new
end
