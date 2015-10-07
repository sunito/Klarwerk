#!/usr/bin/env ruby


require 'active_record'

wurzel = $RAILS_ROOT || File.dirname(File.dirname(__FILE__))

require wurzel + '/app/models/messpunkt'
require wurzel + '/app/models/einheit'
require wurzel + '/app/models/quelle'
require wurzel + '/config/initializers/inflections'

log_dateiname=wurzel + "/log/wert-sy_#{Time.now.strftime('%Y%m%d-%H%M')}.log"
$prot_datei = File.open(log_dateiname, "w")

puts "Werte-Aufnehmer gestartet
Logdatei: #{log_dateiname}"

if :log
  $stdout = $prot_datei
  $stderr = $prot_datei
end




class WerteNotierer
  def initialize(*dyn_klassen)
    @dyn_klassen = dyn_klassen
    @dyn_klasse = dyn_klassen.first
    @dyn_klassennamen = dyn_klassen.map{|dk| dk.name}


#    @dyn_klasse.establish_connection(Rails.configuration.database_configuration["messpunkte_sqlite"])

    p "Verbindung zu Datenbank(en) (#{@dyn_klassennamen}) hergestellt."
    @dyn_klassen.each do |dy_klass|
      p dy_klass.connection
    end

  end

  attr_reader :stopsignal_erhalten

  def init_einleser
    @bei_werteingang = proc do |*args|
      begin
        adr, wert = *args

        zeit = Time.now
        quelle = Quelle.auto_quelle(adr, wert)
        @dyn_klassennamen.each do |kl_name|
          mpunkt = Object.const_get(kl_name).new

          mpunkt.sekzeit = zeit.to_i
          mpunkt.quelle  = quelle
        mpunkt.zahl = wert
        if not mpunkt.save then
          $prot_datei.puts "!" * 40
          $prot_datei.puts "#{kl_name} nicht gesp:" + args.inspect
        end
        end

        $stdout.flush
      rescue
      $prot_datei.puts [zeit.to_i, zeit]
      $prot_datei.puts $!
      $prot_datei.puts $!.backtrace.first(6)
      $stdout.flush
      end

    end

    eigener_haupt_ordner = File.dirname(File.dirname(__FILE__))
    # File.open(File.expand_path("test/fixtures/werte.txt", eigener_haupt_ordner)) 
#    loop do 
    begin
      1_000_000_000_000.times do |i|
        puts
        print "##{i}: "
        speichere_aktuelle_systemwerte
        sleep 1.minute
        # sleep 1.hour
      end
    rescue
      puts "Abbruch #{$!}"
      $prot_datei.puts $!
      $prot_datei.puts $!.backtrace.first(16)
    end

  end

  def speichere_aktuelle_systemwerte
    ausgabe = `df /dev/sda1`
    _platten_name, _max, aktuell, _rest = ausgabe.lines.to_a.last.split(" ")
    wert = aktuell.to_f / 1024
    @bei_werteingang.call("22/disk1", wert)
    print wert
  end

  def stop
  $prot_datei.puts :beginne_stop
    @bei_werteingang = proc {|*args| p :nix}
    if @fiavis_event then
      @fiavis_event.on_event('NewValue') do |*a| p :nothing end
      #@fiavis_event = nil
    end
    #@fiavis = nil

    @stopsignal_erhalten = true
  $prot_datei.puts :ende_stop
  end


  def start
  $prot_datei.puts :beginne_start
    @stopsignal_erhalten = false
    init_einleser

    #Thread.new do
    begin
       $prot_datei.puts :vor_loop
#      loop do
#        begin
#          #WIN32OLE_EVENT.message_loop
#           #$prot_datei.puts :vor_sleep
#          sleep 0.1
#          #$prot_datei.puts :nach_sleep
#          #$prot_datei.print "_"
#          $stdout.flush
#          if @stopsignal_erhalten
#            break
#            $prot_datei.puts :break
#          end
#        rescue
#        $prot_datei.puts( ("!"*40 + "\n") * 3)
#        $prot_datei.puts $!
#        $prot_datei.puts $!.backtrace
#        $prot_datei.puts( ("!"*40 + "\n") * 3)
#          $stdout.flush
#        end
#      end
      #Thread.join
    end
    sleep 0.3
  $prot_datei.puts :ende_start
  end

  def aufraeumen
    daten_behalten_ab = Time.now.to_i - 4.months
    @dyn_klasse.connection.execute("DELETE FROM punkte WHERE punkte.sekzeit > #{daten_behalten_ab}")
  end

end

class MesspunktDb1 < Messpunkt
  establish_connection Rails.configuration.database_configuration["db1"]
end

wn = WerteNotierer.new(MesspunktDb1)
wn.start
