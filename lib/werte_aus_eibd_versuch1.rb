#!/usr/bin/env ruby

# Dieses Script steht unter "lib/", also den Dateinamen und einen Ordner zurück
eigener_haupt_ordner = File.dirname(File.dirname(__FILE__))
# die werte stehen unter "test/fixtures"
File.open(File.expand_path("test/fixtures/werte.txt", eigener_haupt_ordner)) do |datei|
  15.times do |i|
    puts
    print "Zeile #{i}: "
    w = datei.gets
    adresse = w.split[4]
    werte = w.split[5,6]
    next if i < 10

    break if w.nil?

    print adresse
    print werte.join("").to_i(16)
  end
  puts
end
