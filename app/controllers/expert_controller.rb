class ExpertController < ApplicationController
  def schalten
    gefunden = (params[:zustand] =~ /ein/)
    session[:expert_modus] = gefunden ? true : false
    #render :text => "Expertmodus #{session[:expert_modus]}"
    render :action => "expert_bereich", :layout => false
  end
end
