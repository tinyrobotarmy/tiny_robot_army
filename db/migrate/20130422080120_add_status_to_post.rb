class AddStatusToPost < ActiveRecord::Migration
  def change
    add_column :posts, :status_id, :integer
    add_index :posts, :status_id
  end
end
