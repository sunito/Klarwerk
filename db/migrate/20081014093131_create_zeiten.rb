class CreateZeiten < ActiveRecord::Migration
  def self.up
    create_table :zeiten do |t|
      t.datetime :bis
      t.integer  :dauer

      t.timestamps
    end
  end

  def self.down
    drop_table :zeiten
  end
end
