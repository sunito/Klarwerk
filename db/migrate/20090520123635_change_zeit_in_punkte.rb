class ChangeZeitInPunkte < ActiveRecord::Migration
  def self.up
    add_column :punkte, :sekzeit, :integer
    add_column :punkte, :zahl, :float
    remove_column :punkte, :zeit
    remove_column :punkte, :wert
  end

  def self.down
    remove_column :punkte, :sekzeit
    remove_column :punkte, :zahl
    add_column :punkte, :zeit, :datetime
    add_column :punkte, :wert, :string
  end
end

__END__
    alle_pkte = Messpunkt.find(:all)
    alle_pkte.each do |mpunkt|
      mpunkt.sekzeit = mpunkt.zeit.to_i
      mpunkt.save!
    end
