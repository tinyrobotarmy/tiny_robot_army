class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |table|
      table.text :body
      table.integer :author_id
      table.integer :post_id

      table.datetime :updated_at, :null => false
      table.datetime :created_at, :null => false
      table.integer :lock_version, :null => false, :default => 0
    end

    add_index :comments, :author_id
    add_index :comments, :post_id
  end
end
