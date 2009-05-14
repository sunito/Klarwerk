class CreateMesspunkte < ActiveRecord::Migration
  def self.up
    create_table :punkte do |t|
      t.datetime :zeit
      t.string   :wert
      t.integer  :quelle_id
    end
  end

  def self.down
    drop_table :punkte
  end
end
