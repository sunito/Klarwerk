class CreateEinheiten < ActiveRecord::Migration
  def self.up
    create_table :einheiten do |t|
      t.string :name
      t.text :beschreibung
      t.float :min
      t.float :max

      t.timestamps
    end
  end

  def self.down
    drop_table :einheiten
  end
end
