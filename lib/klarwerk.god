
haupt_ordner = File.expand_path("../..", __FILE__)
puts haupt_ordner

God.watch do |w|
  w.name = "klarwerk"


  w.uid = 'kw'
  w.gid = 'users' 
  
  w.dir = haupt_ordner
#  w.log = log/god-process.log'
  w.log = haupt_ordner + '/log/god-process.log'
#  w.start = "script/runner  lib/werte_aus_eibd_v2.rb"
#   = '' + File.expand_path("../../script/runner", __FILE__) + " " + File.expand_path("../werte_aus_eibd_v2.rb", __FILE__) + ''
#  w.start = 'bash -l -c  "' + "script/runner" + " " + "lib/werte_aus_eibd_v2.rb" + '"'
  w.start = 'ruby  ' + File.expand_path("../../script/runner", __FILE__) + " " + haupt_ordner + "/lib/werte_aus_eibd_v2.rb" + ''
#  w.start = '/home/kw/.rvm/rubies/ruby-1.8.7-p358/bin/ruby  ' + File.expand_path("../../script/runner", __FILE__) + " " + haupt_ordner + "/lib/werte_aus_eibd_v2.rb" + ''
#  w.start = 'bash -l -c  "' + File.expand_path("../../script/runner", __FILE__) + " " + File.expand_path("../werte_aus_eibd_v2.rb", __FILE__) + '"'
#  w.start = 'su kw -c \'bash -l -c "' + File.expand_path("../../script/runner", __FILE__) + " " + File.expand_path("../werte_aus_eibd_v2.rb", __FILE__) + '"\''
  w.keepalive
end


God.watch do |w|
  w.name = "rails-server"
  w.uid = 'kw'
  w.gid = 'users'
  w.dir = haupt_ordner
  w.log = haupt_ordner + '/log/god-rails.log'
  w.start = 'ruby  ' + File.expand_path("../../script/server", __FILE__) + "  -p3033" + ''
  w.keepalive
end

