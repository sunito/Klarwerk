class CreateDiaquen < ActiveRecord::Migration
  def self.up
    create_table :diaquen do |t|
      t.integer :quelle_id
      t.integer :diagramm_id
      t.string  :farbe
      t.float   :streckungsfaktor

      t.timestamps
    end
  end

  def self.down
    drop_table :diaquen
  end
end
