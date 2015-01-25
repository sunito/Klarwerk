
einheiten = Einheit.all
ei_meta = Einheit.find(0) || Einheit.new
ei_meta.id = 0
ei_meta.max = 1
ei_meta.min = 0
ei_meta.name = "AKTIV"
ei_meta.beschreibung = "Datenaufnahme aktiv"
ei_meta.save!


