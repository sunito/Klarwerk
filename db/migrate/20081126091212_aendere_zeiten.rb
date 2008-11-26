class AendereZeiten < ActiveRecord::Migration
  def self.up
    remove_column :zeiten, :dauer
    add_column    :zeiten, :dauer, :integer
  end

  def self.down
    remove_column :zeiten, :dauer
    add_column    :zeiten, :dauer, :datetime
  end
end
