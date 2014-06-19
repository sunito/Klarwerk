
def haupt_ordner 
  File.expand_path("../..", __FILE__)
end
puts haupt_ordner

watches = {
  "werte-speicherer" => "script/runner lib/werte_aus_eibd_v2.rb",
  "rails-server"     => "script/server -p3034",
  "eibd-server"      => "eibd -t8 -i ipt:192.168.1.5"
}


def gemeinsam w, name, start_kommando
    w.name = "dev-" + name
    w.group = "entw"
    w.uid = 'kw'
    w.gid = 'users'
    w.dir = haupt_ordner
    w.log = haupt_ordner + "/log/godev-#{name}.log"
    w.start = start_kommando
    #w.stop_signal = "INT"
    w.stop_signal = "QUIT"
end



God.watch do |w|
  gemeinsam w, "werte-speicherer", "script/runner lib/werte_aus_eibd_v2.rb"
  w.keepalive
end


God.watch do |w|
  gemeinsam w, "rails-server",     "script/server -p3034"
  w.keepalive
end

God.watch do |w|
  gemeinsam w, "eibd-server",      "eibd -t8 -i ipt:192.168.1.5"
#  w.keepalive
end

__END__

God.watch do |w|
  w.name = "dev-werte-speicherer"
  w.uid = 'kw'
  w.gid = 'users' 
  w.dir = haupt_ordner
  w.log = haupt_ordner + '/log/godev-werte-speicherer.log'
  w.start = "script/runner lib/werte_aus_eibd_v2.rb" 
#  w.start = "script/runner" + " " + haupt_ordner + "/lib/werte_aus_eibd_v2.rb" + ''
#  w.start = File.expand_path("../../script/runner", __FILE__) + " " + haupt_ordner + "/lib/werte_aus_eibd_v2.rb" + ''
  w.keepalive
end


God.watch do |w|
  w.name = "dev-rails-server"
  w.uid = 'kw'
  w.gid = 'users'
  w.dir = haupt_ordner
  w.log = haupt_ordner + '/log/godev-rails.log'
  w.start = "script/server -p3034"
  w.keepalive
end

God.watch do |w|
  w.name = "dev-eibd-server"
  w.uid = 'kw'
  w.gid = 'users'
  w.log = haupt_ordner + '/log/godev-eibd.log'
  w.start = "eibd -t8 -i ipt:192.168.1.5"
  w.keepalive
end
