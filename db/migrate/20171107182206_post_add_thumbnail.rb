class PostAddThumbnail < ActiveRecord::Migration[5.1]
  def up
    add_column :posts, :thumbnail, :text
  end

  def down
    remove_column :posts, :thumbnail
  end
end
