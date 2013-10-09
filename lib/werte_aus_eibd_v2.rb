#!/usr/bin/env ruby


require 'active_record'

wurzel = $RAILS_ROOT || File.dirname(File.dirname(File.dirname(__FILE__)))

require wurzel + '/app/models/messpunkt'
require wurzel + '/app/models/einheit'
require wurzel + '/app/models/quelle'
require wurzel + '/config/initializers/inflections'

log_dateiname=wurzel + "/log/wert-sp_#{Time.now.strftime('%Y%m%d-%H%M')}.log"
$prot_datei = File.open(log_dateiname, "w")

puts "Werte-Aufnehmer gestartet
Logdatei: #{log_dateiname}"

if :log
  $stdout = $prot_datei
  $stderr = $prot_datei
end

unless `ps -ef`  =~ /eibd /
  $eibd = IO.popen("eibd  -t1023 -i ipt:192.168.1.5")
  puts "eibd gestartet"
  sleep 0.3
end  
$socket_listener = IO.popen("groupsocketlisten ip:localhost")
puts "listener gestartet"


class Float
  alias :altes_to_s :to_s
  def to_s
    altes_to_s.gsub(",", ".")
  end
end

class WerteNotierer
  def initialize(dyn_klasse)
    @dyn_klasse = dyn_klasse
    @dyn_klassenname = dyn_klasse.name


#    @dyn_klasse.establish_connection(Rails.configuration.database_configuration["messpunkte_sqlite"])

    p "Verbindung zur Datenbank hergestellt."
    p @dyn_klasse.connection

=begin
    conn =
      {
                :adapter => "sqlite3",
                :database => "db/klarwerk_dev.sqlite3",
                :pool =>  5,
                :timeout =>  5000,
      }
=end

#    Quelle.establish_connection(conn)
 #   Einheit.establish_connection(conn)
  end

  attr_reader :stopsignal_erhalten

  def init_einleser
    @bei_werteingang = proc do |*args|
      begin
        adr, wert = *args

        mpunkt = Object.const_get(@dyn_klassenname).new
        zeit = Time.now

        mpunkt.sekzeit = zeit.to_i
        #!!db!! 
        mpunkt.quelle = Quelle.auto_quelle(adr, wert)
        mpunkt.zahl = wert
        if not mpunkt.save then
          $prot_datei.puts "!" * 40
          $prot_datei.puts "nicht gesp:" + args.inspect
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
        print "Zeile #{i}: "
        w = $socket_listener.gets
        puts w.inspect
        #next if i < 10
        break if w.nil?

        adresse = w.split[4].chomp(":")
        werte = begin w.split[5,6] || [-17] rescue [42] end
        #print "Werte >>#{werte.inspect}<<"
        #puts
        
        adresse = adresse.split("/").zip([2,1,3]).map do |teil_adr, stellen|
          "%0#{stellen}d" % teil_adr.to_i
        end.join("/")
        #adr_teile[2] = ("00" + adr_teile[2])[-3..-1]
        #adresse = adr_teile.join("/")
        print adresse + ": "
        print werte.join("").to_i(16).to_s   +   " "
        
        float_wert = werte.join("").to_i(16).to_f/100
        @bei_werteingang.call(adresse, float_wert)
        print float_wert
      end
    rescue
      puts "Abbruch #{$!}"
      $prot_datei.puts $!
      $prot_datei.puts $!.backtrace.first(16)
    end

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


wn = WerteNotierer.new(Messpunkt)
wn.start
