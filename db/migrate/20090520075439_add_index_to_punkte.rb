class AddIndexToPunkte < ActiveRecord::Migration
  def self.up
    add_index :punkte, :zeit
    add_index :punkte, :quelle_id
  end

  def self.down
    remove_index :punkte, :zeit
    remove_index :punkte, :quelle_id
  end
end
