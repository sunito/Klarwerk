# encoding: utf-8

class Messpunkt < ActiveRecord::Base
  unless Rails.env.test?
  establish_connection Rails.configuration.database_configuration["messpunkte"]
  end
  #set_table_name :punkte
  belongs_to :quelle
  composed_of :zeit, :class_name => "Time"
  attr_accessible :sekzeit, :quelle_id, :zahl
  
  def wert
    zahl
  end

  def wert= neuer_wert
    self.zahl = neuer_wert.to_f
  end

  def zeit
    sekzeit and  Time.at(sekzeit)
  end

  def zeit= neue_zeit
    self.sekzeit = neue_zeit.to_i
  end

  def quell_adresse=(adresse)
    q = Quelle.find_by_adr(adresse)
    if not q then
      q = Quelle.new
      q.adr = adresse
      q.name = "Messgroesze fuer #{adresse}"
      q.beschr = q.name + ", generiert am #{Time.now}."
      q.typ = "unbekannt"
      q.einheit = Einheit.auto_einheit
      q.save!
    end
    
    self.quelle_id = q.id
    if not self.save then
      p "Speichern hat nicht geklappt!"
    else 
      #p "speichern OK!!!!!"
    end
    adresse
  end


  def self.finde_fuer_quelle_und_zeit(quelle, zeit)
    quelle_id = quelle.id
    finde_von_bis = proc do |von, bis|
      find(:all, {
        :conditions => ["(quelle_id = ?) and (sekzeit >= ?) and (sekzeit <= ?)", quelle_id, von.to_i, bis.to_i],
        :order => :sekzeit
      })
    end
    mpunkte_im_intervall = finde_von_bis.call(zeit.vonzeit, zeit.biszeit)

    # Wenn nicht gleich am Anfang ein Punkt ist, schauen wir davor
    if mpunkte_im_intervall.empty? or mpunkte_im_intervall.first.zeit > zeit.vonzeit + zeit.dauer/100 then

      mpunkte_im_intervall_davor = if mpunkte_im_intervall.size > 0 then
        dauer_fuer_etwa_10_mpunkte = zeit.dauer * 100.0 / mpunkte_im_intervall.size
        geschaetzte_10_mpunkte_zurueck = zeit.vonzeit - dauer_fuer_etwa_10_mpunkte.to_i
        finde_von_bis.call(geschaetzte_10_mpunkte_zurueck, zeit.vonzeit)
      else
        []
      end
      if mpunkte_im_intervall_davor.empty? then
        p ["empty"]
        mpunkte_im_intervall_davor = finde_von_bis.call(zeit.vonzeit - 1.days, zeit.vonzeit)
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

