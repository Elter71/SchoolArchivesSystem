class Post < ApplicationRecord
  validates :title, :description, presence: true
  belongs_to :user

  def destroy
    super
    FileUtils.rm_rf(Configuration.instance.server_path+"#{id}/")
  end

  def delete
    super
    destroy
  end

end