
ARGV << "-p3030" 

wurzel = File.dirname(File.dirname(__FILE__))

log_dateiname=wurzel + "/log/diagramm-server_#{Time.now.strftime('%Y%m%d-%H%M')}.log"
diagramm_server_prot_datei = File.open(log_dateiname, "w")
$stdout = diagramm_server_prot_datei
$stderr = diagramm_server_prot_datei

load File.join(wurzel, "script/server")
