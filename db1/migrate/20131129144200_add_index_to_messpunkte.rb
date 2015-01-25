class AddIndexToMesspunkte < ActiveRecord::Migration
  def self.up
    add_index :messpunkte, :sekzeit
    add_index :messpunkte, :quelle_id
  end

  def self.down
    remove_index :messpunkte, :sekzeit
    remove_index :messpunkte, :quelle_id
  end
end
