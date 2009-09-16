class CreateQuellen < ActiveRecord::Migration
  def self.up
    create_table :quellen do |t|
      t.string  :adresse
      t.string  :name
      t.string  :variablen_art
      t.text    :beschreibung
      t.integer :einheit_id
      t.string  :farbe
      t.integer :status

      t.timestamps
    end
  end

  def self.down
    drop_table :quellen
  end
end
