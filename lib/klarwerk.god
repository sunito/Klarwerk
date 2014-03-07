
haupt_ordner = File.expand_path("../..", __FILE__)
puts haupt_ordner

God.watch do |w|
  w.name = "werte-speicherer"
  w.uid = 'kw'
  w.gid = 'users' 
  w.dir = haupt_ordner
  w.log = haupt_ordner + '/log/god-werte-speicherer.log'
  w.start = "script/runner lib/werte_aus_eibd_v2.rb" 
#  w.start = "script/runner" + " " + haupt_ordner + "/lib/werte_aus_eibd_v2.rb" + ''
#  w.start = File.expand_path("../../script/runner", __FILE__) + " " + haupt_ordner + "/lib/werte_aus_eibd_v2.rb" + ''
  w.keepalive
end


God.watch do |w|
  w.name = "rails-server"
  w.uid = 'kw'
  w.gid = 'users'
  w.dir = haupt_ordner
  w.log = haupt_ordner + '/log/god-rails.log'
  w.start = "script/server -p3033"
  w.keepalive
end

God.watch do |w|
  w.name = "eibd-server"
  w.uid = 'kw'
  w.gid = 'users'
  w.log = haupt_ordner + '/log/god-eibd.log'
  w.start = "eibd -t8 -i ipt:192.168.1.5"
  w.keepalive
end