
haupt_ordner = File.expand_path("..", __FILE__)
puts haupt_ordner

God.watch do |w|
  w.name = "klarwerk"
  w.start = 'su kw -c \'bash -l -c "' + File.expand_path("../../script/runner", __FILE__) + " " + File.expand_path("../werte_aus_eibd_v2.rb", __FILE__) + '"\''
  w.keepalive
end
