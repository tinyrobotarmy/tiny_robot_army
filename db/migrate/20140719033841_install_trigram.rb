class InstallTrigram < ActiveRecord::Migration[6.1]
  def self.up
    ActiveRecord::Base.connection.execute("CREATE EXTENSION pg_trgm;")
  end

  def self.down
    ActiveRecord::Base.connection.execute("DROP EXTENSION pg_trgm;")
  end
end
