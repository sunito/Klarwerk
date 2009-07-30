class AddSekIndexToPunkte < ActiveRecord::Migration
 def self.up
    remove_index :punkte, :quelle_id
    add_index :punkte, [:quelle_id, :sekzeit]
  end

  def self.down
    remove_index :punkte, [:quelle_id, :sekzeit]
    add_index :punkte, :quelle_id
  end
end
