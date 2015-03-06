class AddGequanteltToEinheiten < ActiveRecord::Migration
  def self.up
    add_column :einheiten, :gequantelt, :bool
  end

  def self.down
  	remove_column :einheiten, :gequantelt
  end
end
