# To change this template, choose Tools | Templates
# and open the template in the editor.

GLOBAL_X_ANZAHL = 400

class Kurve < Struct.new(:diaque, :von, :bis, :x_anzahl)

  def initialize(diaque, diagramm_zeit = nil)
    #p :new_diamo
    if not diagramm_zeit then
      #diaque_zeit = DiagrammZeit.new
      diagramm_zeit = diaque.diagramm.zeit
    end
    if not diagramm_zeit.bis then
      bis = Time.now
    else
      bis = diagramm_zeit.bis
    end
    dauer = diagramm_zeit.dauer || diaque.diagramm.zeit.dauer
    von = bis - dauer

    super diaque, von, bis, GLOBAL_X_ANZAHL

    @linien_daten = nil
  end

  def x_schritt
    @x_schritt ||= (self.bis - self.von) / self.x_anzahl
  end

  def x_zeiten
    (0 .. self.x_anzahl).map do |n|
      self.von   +   n * self.x_schritt
    end
  end

  def linien_daten
    @linien_daten ||= begin
      dyns = Messpunkt.find(:all,
                      {:conditions => ["(quelle_id = ?) and (zeit >= ?) and (zeit <= ?)",
                                        diaque.quelle.id,    self.von,       self.bis],
                        :order => :zeit})
      p [:dyns, dyns.size, dyns.first]
      dyn_paare = dyns.map {|z| if z then [z.zeit, z.wert] end }.compact

      if x_anzahl and x_anzahl > 0 then

        orig_paare_uebrig = dyn_paare.clone
        erg_werte = []
        p x_anzahl
        x_anzahl.times do |n|
          abschnitts_ende = self.von  +  (n+1) * x_schritt

          werte_in_abschnitt = werte_abspalten_bis(orig_paare_uebrig, abschnitts_ende)

          erg = if werte_in_abschnitt.empty? then
            nil
          else
            #werte_in_abschnitt.sum  /  werte_in_abschnitt.size
            werte_in_abschnitt[werte_in_abschnitt.size/2]
          end

          erg_werte << erg
        end
      else
        erg_werte = dyn_werte

      end

      p :linie_fertig
      erg_werte
    end
  end

  def y_bereich

  end

  def skalen
    @skalen ||= diagramm.quellen.map do |quelle|
      ld = linien_daten_fuer(quelle)
      daten_ohne_nil = ld.compact
      min = daten_ohne_nil.min || 0
      max = daten_ohne_nil.max || 1
      min..max
    end
  end

private
  def werte_abspalten_bis(sortierte_paare, biszeit)
    werte_in_abschnitt = []
    while not sortierte_paare.empty? do
      paar = sortierte_paare.first
      zeit, wert = paar
      if zeit > biszeit then
        break
      else
        werte_in_abschnitt << wert.to_f
        sortierte_paare.shift  # paar verbraucht
      end
    end
    werte_in_abschnitt
  end


end
