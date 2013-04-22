class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :title
      t.string :slug
      t.text :description

      t.timestamps
    end

    create_table :categories_posts, id: false do |t|
      t.integer :category_id
      t.integer :post_id
    end
    add_index :categories_posts, :category_id
    add_index :categories_posts, :post_id
  end
end
