QLTtCbvcSgu::Application.routes.draw do

	#Casein routes
	namespace :casein do
		resources :cong_viecs
		resources :loai_lao_dongs
		resources :loai_don_vis
		resources :quan_he_gia_dinhs do
      get "import_from_excel", :on => :collection
      post "parse_save_from_excel", :on => :collection
    end
		resources :hang_thuong_binhs do
      get "import_from_excel", :on => :collection
      post "parse_save_from_excel", :on => :collection
    end
		resources :cap_bac_quan_dois do
      get "import_from_excel", :on => :collection
      post "parse_save_from_excel", :on => :collection
    end
		resources :qua_trinh_cong_tacs do
      get "import_from_excel", :on => :collection
      post "parse_save_from_excel", :on => :collection
      get "details", :on => :collection
    end
		resources :can_bo_cong_tacs do
    get "import_from_excel", :on => :collection
    post "parse_save_from_excel", :on => :collection
    end
		resources :don_vis do
      get "import_from_excel", :on => :collection
      post "parse_save_from_excel", :on => :collection
    end
		resources :chuc_vus do
      get "import_from_excel", :on => :collection
      post "parse_save_from_excel", :on => :collection
    end
		resources :lich_su_bac_luongs do
    get "import_from_excel", :on => :collection
    post "parse_save_from_excel", :on => :collection
	get	"details", :on => :collection
    end
		resources :bac_luongs do
      get "import_from_excel", :on => :collection
      post "parse_save_from_excel", :on => :collection
    end
		resources :ngaches do
      get "import_from_excel", :on => :collection
      post "parse_save_from_excel", :on => :collection
    end
		resources :ngoai_ngus do
      get "import_from_excel", :on => :collection
      post "parse_save_from_excel", :on => :collection
    end
		resources :can_bo_trinh_dos do
      get "import_from_excel", :on => :collection
      post "parse_save_from_excel", :on => :collection
    end
		resources :quan_ly_nha_nuocs do
      get "import_from_excel", :on => :collection
      post "parse_save_from_excel", :on => :collection
    end
		resources :ly_luan_chinh_tris do
      get "import_from_excel", :on => :collection
      post "parse_save_from_excel", :on => :collection
    end
		resources :trinh_do_chuyen_mons do
      get "import_from_excel", :on => :collection
      post "parse_save_from_excel", :on => :collection
    end
		resources :chuyen_nganhs do
      get "import_from_excel", :on => :collection
      post "parse_save_from_excel", :on => :collection
    end
		resources :quyet_dinhs  do
      get "import_from_excel", :on => :collection
      post "parse_save_from_excel", :on => :collection
    end
		resources :loai_quyet_dinhs do
      get "import_from_excel", :on => :collection
      post "parse_save_from_excel", :on => :collection
    end
		resources :hoc_hams do
      get "import_from_excel", :on => :collection
      post "parse_save_from_excel", :on => :collection
    end
		resources :hoc_vis do
      get "import_from_excel", :on => :collection
      post "parse_save_from_excel", :on => :collection
    end
		resources :can_bo_li_lich_cts  do
      get "import_from_excel", :on => :collection
      post "parse_save_from_excel", :on => :collection
    end
		resources :than_nhans do
      get "import_from_excel", :on => :collection
      post "parse_save_from_excel", :on => :collection
      get "details", :on => :collection
    end
		resources :params do
      get "import_from_excel", :on => :collection
      post "parse_save_from_excel", :on => :collection
    end
		resources :can_bo_thong_tins do
      get "import_from_excel", :on => :collection
      post "parse_save_from_excel", :on => :collection
      get "advance_search", :on => :collection
      get "statistic", :on => :collection
      get "statistic_by_age", :on => :collection
      get "statistic_by_trinh_do_chuyen_mon", :on => :collection
      get "statistic_by_loai_lao_dong", :on => :collection
      get "statistic_by_cong_viec", :on => :collection
      get "statistic_total", :on => :collection
      get "custom_export_data", :on => :collection
      get "get_and_export_to_excel", :on => :collection
      get "random_record", :on => :collection
      post "exe_random_record", :on => :collection
      get  "print", :on => :collection

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
  root :to => 'casein/can_bo_thong_tins#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
