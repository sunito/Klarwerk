class CreateDiagramme < ActiveRecord::Migration
  def self.up
    create_table :diagramme do |t|
      t.string :name
      t.text :beschreibung
      t.integer :zeit_id

      t.timestamps
    end
  end

  def self.down
    drop_table :diagramme
  end
end
