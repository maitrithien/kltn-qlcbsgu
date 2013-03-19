QLTtCbvcSgu::Application.routes.draw do

	#Casein routes
	namespace :casein do
		resources :quan_he_gia_dinhs
		resources :qua_trinh_cong_tacs
		resources :can_bo_cong_tacs do
    get "import_from_excel", :on => :collection
    post "parse_save_from_excel", :on => :collection
    end
		resources :don_vis
		resources :chuc_vus
		resources :lich_su_bac_luongs
		resources :bac_luongs
		resources :ngaches
		resources :ngoai_ngus
		resources :can_bo_trinh_dos
		resources :quan_ly_nha_nuocs
		resources :ly_luan_chinh_tris
		resources :trinh_do_chuyen_mons do
      get "import_from_excel", :on => :collection
      post "parse_save_from_excel", :on => :collection
    end
		resources :chuyen_nganhs do
      get "import_from_excel", :on => :collection
      post "parse_save_from_excel", :on => :collection
    end
		resources :quyet_dinhs
		resources :loai_quyet_dinhs
		resources :hoc_hams
		resources :hoc_vis
		resources :can_bo_li_lich_cts  do
      get "import_from_excel", :on => :collection
      post "parse_save_from_excel", :on => :collection
    end
		resources :than_nhans do
      get "import_from_excel", :on => :collection
      post "parse_save_from_excel", :on => :collection
    end
		resources :params do
      get "import_from_excel", :on => :collection
      post "parse_save_from_excel", :on => :collection
    end
		resources :can_bo_thong_tins do
      get "import_from_excel", :on => :collection
      post "parse_save_from_excel", :on => :collection
      get "advance_search", :on => :collection
    end

	end

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
