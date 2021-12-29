class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |table|
      table.string :subject
      table.text :body
      table.integer :author_id

      table.datetime :updated_at, :null => false
      table.datetime :created_at, :null => false
      table.integer :lock_version, :null => false, :default => 0
    end

    add_index :posts, :author_id
  end

end
