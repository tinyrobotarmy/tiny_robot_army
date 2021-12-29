class AddSearchIndexes < ActiveRecord::Migration[6.1]
  def up
    execute <<-SQL
      create index on posts using gin(to_tsvector('english', subject));
      create index on posts using gin(to_tsvector('english', body));
    SQL
  end
end
