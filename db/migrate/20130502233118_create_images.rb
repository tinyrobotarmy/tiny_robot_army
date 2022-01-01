class CreateImages < ActiveRecord::Migration[6.1]
  def change
    create_table :images do |t|
      t.string :file

      t.datetime :updated_at, :null => false
      t.datetime :created_at, :null => false
      t.integer :lock_version, :null => false, :default => 0
    end
  end
end
