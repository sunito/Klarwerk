# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  
  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery :only => [:update, :destroy] # :secret => '4144dba2356ef11b1771b83d248a0180'
  #protect_from_forgery
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password

  before_filter :expert_modus_aktualisieren

  def expert_modus_aktualisieren
    if params[:expert] then
      session[:expert_modus] = params[:expert]=="ein" 
    end
  end
  
end
