class Messpunkt < ActiveRecord::Base
  belongs_to :quelle #, :foreign_key => :pumuckl_id

  def self.finde_fuer_quelle_und_zeit(quelle, zeit)
    quelle_id = quelle.id
    finde_von_bis = proc do |von, bis|
      find(:all, {
        :conditions => ["(quelle_id = ?) and (zeit >= ?) and (zeit <= ?)", quelle_id, von, bis],
        :order => :zeit
      })
    end
    mpunkte_im_intervall = finde_von_bis.call(zeit.vonzeit, zeit.biszeit)

    # Wenn nicht gleich am Anfang ein Punkt ist, schauen wir davor
    if mpunkte_im_intervall.empty? or mpunkte_im_intervall.first.zeit > zeit.vonzeit + zeit.dauer/100 then

      mpunkte_im_intervall_davor = if mpunkte_im_intervall.size > 0 then
        dauer_fuer_etwa_10_mpunkte = zeit.dauer * 10.0 / mpunkte_im_intervall.size
        geschaetzte_10_mpunkte_zurueck = zeit.vonzeit - dauer_fuer_etwa_10_mpunkte.to_i
        finde_von_bis.call(geschaetzte_10_mpunkte_zurueck, zeit.vonzeit)
      else
        []
      end
      if mpunkte_im_intervall_davor.empty? then
        mpunkte_im_intervall_davor = finde_von_bis.call(Time.local(2000,4,28), zeit.vonzeit)
      end
      mpunkt_davor = mpunkte_im_intervall_davor.last
      if mpunkt_davor then
        mpunkt_anfang = self.new
        mpunkt_anfang.zeit = zeit.vonzeit
        mpunkt_anfang.wert = mpunkt_davor.wert
        mpunkt_anfang.quelle = mpunkt_davor.quelle
        mpunkte_im_intervall.unshift mpunkt_anfang
      end
    end
    
    mpunkte_im_intervall
  end
end
