class ExpertController < ApplicationController
  def schalten
    gefunden = (params[:zustand] =~ /ein/)
    p "EXPERTMODUS #{gefunden}"
    session[:expert_modus] = gefunden ? true : false
    warn "EXPERTMODUS #{session[:expert_modus]}"
    #render :text => "Expertmodus #{session[:expert_modus]}"
    if request.xhr? then
      render :partial => "expert_bereich", :layout => false
    else
      redirect_to request.request_uri
    end
  end

end
