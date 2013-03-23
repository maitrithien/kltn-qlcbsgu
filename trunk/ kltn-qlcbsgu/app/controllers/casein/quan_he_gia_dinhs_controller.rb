# Scaffolding generated by Casein v.3.1.11

module Casein
  class QuanHeGiaDinhsController < Casein::CaseinController
  
    ## optional filters for defining usage according to Casein::Users access_levels
    # before_filter :needs_admin, :except => [:action1, :action2]
    # before_filter :needs_admin_or_current_user, :only => [:action1, :action2]
  
    def index
      @casein_page_title = Param.get_param_value "quan_he_gia_dinh_index_page_title"
  		@quan_he_gia_dinhs = QuanHeGiaDinh.paginate :page => params[:page], :per_page => 10
    end
  
    def show
      @casein_page_title = Param.get_param_value "quan_he_gia_dinh_show_page_title"
      @quan_he_gia_dinh = QuanHeGiaDinh.find params[:id]
    end
 
    def new
      @casein_page_title = Param.get_param_value "quan_he_gia_dinh_new_page_title"
    	@quan_he_gia_dinh = QuanHeGiaDinh.new
    end

    def create
      @quan_he_gia_dinh = QuanHeGiaDinh.new params[:quan_he_gia_dinh]
    
      if @quan_he_gia_dinh.save
        flash[:notice] = Param.get_param_value "adding_success"
        redirect_to casein_quan_he_gia_dinhs_path
      else
        flash.now[:warning] = Param.get_param_value "adding_false"
        render :action => :new
      end
    end
  
    def update
      @casein_page_title = Param.get_param_value "quan_he_gia_dinh_update_page_title"
      
      @quan_he_gia_dinh = QuanHeGiaDinh.find params[:id]
    
      if @quan_he_gia_dinh.update_attributes params[:quan_he_gia_dinh]
        flash[:notice] = Param.get_param_value "updating_success"
        redirect_to casein_quan_he_gia_dinhs_path
      else
        flash.now[:warning] = Param.get_param_value "updating_false"
        render :action => :show
      end
    end
 
    def destroy
      @quan_he_gia_dinh = QuanHeGiaDinh.find params[:id]

      @quan_he_gia_dinh.destroy
      flash[:notice] = Param.get_param_value "deleting_success"
      redirect_to casein_quan_he_gia_dinhs_path
    end
  
  end
end