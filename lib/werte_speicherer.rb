require 'active_record'

wurzel = "E:/KabDiag/klarwerk"

require wurzel + '/app/models/messpunkt'
require wurzel + '/app/models/einheit'
require wurzel + '/app/models/quelle'
require wurzel + '/config/initializers/inflections'

log_dateiname=wurzel + "/log/wert-sp_#{Time.now.strftime('%Y%m%d-%H%M')}.log"
$prot_datei = File.open(log_dateiname, "w")

puts "Werte-Aufnehmer gestartet
Logdatei: #{log_dateiname}"

$stdout = $prot_datei
$stderr = $prot_datei

IST_WINDOWS = PLATFORM =~ /win/ 

if IST_WINDOWS then
  require 'win32ole'
end

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
    
    conn = {:adapter => :mysql,
                :encoding => :utf8,
                :database => "kabdiag_aktuell",
                :username => "root",
                :password => "kab"
                }

    @dyn_klasse.establish_connection(conn)
                
    p "Verbindung zur Datenbank hergestellt."
    p @dyn_klasse.connection

    Quelle.establish_connection(conn)
    Einheit.establish_connection(conn)
  end

  attr_reader :stopsignal_erhalten

  def init_fiavis
    @fiavis ||= WIN32OLE.new('FIAVISVB.FIAVisIF')
    @fiavis.Connect

    @fiavis_event = WIN32OLE_EVENT.new(@fiavis, '_IFIAVisIFEvents')

    @fiavis_event.on_event('NewValue') do |*args|
      @bei_werteingang.call(*args)
    end
    @bei_werteingang = proc do |*args|
      begin
        #p "@stopsignal_erhalten=#{stopsignal_erhalten}"
        verbindung, typ, adr, wert = *args
        
        if typ != "GV" then
        #$prot_datei.puts args

          #dp = @dyn_klasse.new <-- funktioniert nicht!!
          mpunkt = Object.const_get(@dyn_klassenname).new
          # im Prinzip also: dp = Dyn.new

          zeit = Time.now
          mpunkt.sekzeit = zeit.to_i

          
          mpunkt.quelle = Quelle.auto_quelle(adr, wert)
          #dp.verbindung = verbindung
          #dp.adr = adr
          #dp.typ = typ
          mpunkt.zahl = wert.gsub(",", ".").to_f
          if not mpunkt.save then
            $prot_datei.puts "!" * 40
            $prot_datei.puts "nicht gesp:" + args.inspect
          end
          #dyn_neu = Messpunkt.find(dyn.id-5)
          #p ["Eingang:", wert]

          #$prot_datei.puts "#{Time.now.strftime('%H:%M:%S')} #{args.inspect}"
        end
        
        $stdout.flush
      rescue
      $prot_datei.puts [zeit.to_i, zeit]
      $prot_datei.puts $!
      $prot_datei.puts $!.backtrace.first(6)
      $stdout.flush
      end
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
    #p "@stopsignal_erh=#{@stopsignal_erhalten}"
  $prot_datei.puts :ende_stop
  end


  def start
  $prot_datei.puts :beginne_start
    @stopsignal_erhalten = false
    init_fiavis if IST_WINDOWS

    #Thread.new do
    begin
       $prot_datei.puts :vor_loop
      loop do
        begin
          WIN32OLE_EVENT.message_loop
           #$prot_datei.puts :vor_sleep
          sleep 0.1
          #$prot_datei.puts :nach_sleep
          #$prot_datei.print "_"
          $stdout.flush
          if @stopsignal_erhalten
            break
            $prot_datei.puts :break
          end
        rescue
        $prot_datei.puts( ("!"*40 + "\n") * 3)
        $prot_datei.puts $!
        $prot_datei.puts $!.backtrace
        $prot_datei.puts( ("!"*40 + "\n") * 3)
          $stdout.flush
        end
      end
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
