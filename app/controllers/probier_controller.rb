class ProbierController < ApplicationController
  def index
  @chart = LazyHighCharts::HighChart.new('graph') do |f|
      @punkte = []
      @zeitpunkte = []
      tag = ""
      counter = 0
      anzeigedichte = 10
      Messpunkt.where(:id => 0 .. 1000).each do |e| #Datenarrays füllen
        if e.zahl > 20 then #Werte kleiner 20 werden "außer acht" gelassen --> "Falsche" Daten bzw nicht relevant?
          counter = counter +1
        end
        if counter >= anzeigedichte then #Aufnahme von Daten aus DB
          @punkte << e.zahl
          s = Time.at(e.sekzeit).sec
          min = Time.at(e.sekzeit).min
          h = Time.at(e.sekzeit).hour
          d = Time.at(e.sekzeit).day
          m = Time.at(e.sekzeit).month
          y = Time.at(e.sekzeit).year
          zeit = "#{h}:#{min}:#{s}"
          tag = "#{d}.#{m}.#{y}"
          #alternativ: tag = Time.at(e.sekzeit).to_date 
          @zeitpunkte << zeit
          counter = 0
        end 
      end
      f.title({:text=>"Messpunkte"})
      f.series(:type=> 'line', :name=> 'Punkte', :data=> @punkte)
      f.x_axis({ :categories => @zeitpunkte})
      f.title({:text => "Werte vom #{tag}"}) #Problem: Wenn mehr als ein Tag angezeigt wird, wird als Titel nur Datum eines Tages angezeigt 
    end
  
  end
end
