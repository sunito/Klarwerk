module DiagrammeHelper

  def navigations_dauern(akt_zeit)
    anzahl_weiter = 2
    laenger = (1..anzahl_weiter).inject([akt_zeit]) {|zeiten, idx| [zeiten.first.laenger] + zeiten}
    kuerzer = (1..anzahl_weiter).inject([akt_zeit]) {|zeiten, idx| zeiten + [zeiten.last.kuerzer]}
    dauern = (laenger + [akt_zeit] + kuerzer).map(&:dauer)
    dauern += [1.weeks, 12.hours]
    dauern = dauern.uniq.sort.reverse
    dauern += [nil] if dauern.size < 2 * anzahl_weiter + 1 + 2
    dauern
  end
end
