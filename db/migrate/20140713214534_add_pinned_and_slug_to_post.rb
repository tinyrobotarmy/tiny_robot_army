class AddPinnedAndSlugToPost < ActiveRecord::Migration
  def up
    execute 'delete from posts'
    add_column :posts, :pinned, :boolean, null: false, default: false
    add_column :posts, :slug, :string
  end

  def down
    remove_column :posts, :pinned
    remove_column :posts, :slug
  end
end
