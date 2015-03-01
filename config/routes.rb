#ActionController::Routing::Routes.draw do |map|
Klarwerk::Application.routes.draw do


  get "probier/probier"

  get "probier_controller/probier_view"

  get "diagramm/index"

  resources :messpunkte
  resources :einheiten

 
  resources :quellen
  match 'quellen/:id/aktiv_umschalten' => 'quellen#aktiv_umschalten', :as => :aktiv_umschalten
  match 'quellen/:id/generiere/:tage/:tage_zurueck' => 'quellen#generiere', :as => :werte_generieren
  
  resources :zeiten
  
  resources :diagramme
  resources :diaquen
  
  match 'diagramme/:id/showfix' => 'diagramme#showfix', :as => :showfix
  match 'diagramme/:id/ajja' => 'diagramme#ajja', :as => :ajja
  
  match 'expert_modus/:zustand' => 'expert#schalten', :as => :expert_modus
  match 'diagramme/:id/dauer/:dauer' => 'diagramme#dauer', :as => :quelle_rein
  match 'diagramme/:id/quelle_rein/:quelle_id' => 'diagramme#quelle_rein', :as => :quelle_rein
  match 'diagramme/:id/quelle_raus/:quelle_id' => 'diagramme#quelle_raus', :as => :quelle_raus
  
  match '/' => 'diagramme#index'
  
  match '/:controller(/:action(/:id))'
end
__END__
  map.resources :messpunkte
  map.resources :einheiten
  
  map.resources :quellen
  map.aktiv_umschalten 'quellen/:id/aktiv_umschalten', :controller => 'quellen', :action => 'aktiv_umschalten'
  map.werte_generieren 'quellen/:id/generiere/:tage/:tage_zurueck', :controller => 'quellen', :action => 'generiere'

  map.resources :zeiten

  map.resources :diagramme, :has_many => :diaquen  # Verschachtelt ("nested ressource")
  map.resources :diaquen  # Damit sind die diaquen auch nichtverschachtelt zugreifbar.

  map.showfix 'diagramme/:id/showfix', :controller => 'diagramme', :action => 'showfix'

  map.expert_modus 'expert_modus/:zustand', :controller => 'expert', :action => 'schalten'
  map.quelle_rein 'diagramme/:id/dauer/:dauer', :controller => 'diagramme', :action => 'dauer'
  map.quelle_rein 'diagramme/:id/quelle_rein/:quelle_id', :controller => 'diagramme', :action => 'quelle_rein'
  map.quelle_raus 'diagramme/:id/quelle_raus/:quelle_id', :controller => 'diagramme', :action => 'quelle_raus'

  map.root :controller => "diagramme", :action => "index"

  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  # map.root :controller => "welcome"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing the them or commenting them out if you're using named routes and resources.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
