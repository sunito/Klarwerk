module DiagrammeHelper
  def navi_dauern(zeit)
   dauern = [zeit.laenger, zeit, zeit.kuerzer].map(&:dauer)
   dauern += [1.weeks, 12.hours]
   dauern = dauern.uniq.sort.reverse
   dauern += [nil] if dauern.size < 5
   dauern
  end


end
