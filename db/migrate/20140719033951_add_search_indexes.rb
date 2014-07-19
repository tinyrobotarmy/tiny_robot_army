class AddSearchIndexes < ActiveRecord::Migration
  def up
    execute <<-SQL
      create index on posts using gin(to_tsvector('english', subject));
      create index on posts using gin(to_tsvector('english', body));
    SQL
  end
end
