# Scaffolding generated by Casein v.3.1.11

module Casein
  class TrinhDoChuyenMonsController < Casein::CaseinController
  
    ## optional filters for defining usage according to Casein::Users access_levels
    # before_filter :needs_admin, :except => [:action1, :action2]
    # before_filter :needs_admin_or_current_user, :only => [:action1, :action2]
  
    def index
      @casein_page_title = Param.get_param_value("trinh_do_chuyen_mon_index_page_title")
  		@trinh_do_chuyen_mons = TrinhDoChuyenMon.paginate :page => params[:page]
    end
  
    def show
      @casein_page_title = Param.get_param_value("trinh_do_chuyen_mon_show_page_title")
      @trinh_do_chuyen_mon = TrinhDoChuyenMon.find params[:id]
    end
 
    def new
      @casein_page_title = Param.get_param_value("trinh_do_chuyen_mon_new_page_title")
    	@trinh_do_chuyen_mon = TrinhDoChuyenMon.new
    end

    def create
      @trinh_do_chuyen_mon = TrinhDoChuyenMon.new params[:trinh_do_chuyen_mon]
    
      if @trinh_do_chuyen_mon.save
        flash[:notice] = Param.get_param_value("adding_success")
        redirect_to casein_trinh_do_chuyen_mons_path
      else
        flash.now[:warning] = Param.get_param_value("adding_false")
        render :action => :new
      end
    end
  
    def update
      @casein_page_title = Param.get_param_value("trinh_do_chuyen_mon_update_page_title")
      
      @trinh_do_chuyen_mon = TrinhDoChuyenMon.find params[:id]
    
      if @trinh_do_chuyen_mon.update_attributes params[:trinh_do_chuyen_mon]
        flash[:notice] = Param.get_param_value("updating_success")
        redirect_to casein_trinh_do_chuyen_mons_path
      else
        flash.now[:warning] = Param.get_param_value("updating_false")
        render :action => :show
      end
    end
 
    def destroy
      @trinh_do_chuyen_mon = TrinhDoChuyenMon.find params[:id]

      @trinh_do_chuyen_mon.destroy
      flash[:notice] = Param.get_param_value("deleting_success")
      redirect_to casein_trinh_do_chuyen_mons_path
    end
  
  end
end