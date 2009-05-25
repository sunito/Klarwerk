class AddSekIndexToPunkte < ActiveRecord::Migration
 def self.up
    add_index :punkte, :sekzeit
  end

  def self.down
    remove_index :punkte, :sekzeit
  end
end
