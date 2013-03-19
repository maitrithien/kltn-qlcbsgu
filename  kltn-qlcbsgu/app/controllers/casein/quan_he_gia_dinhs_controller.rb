# Scaffolding generated by Casein v.3.1.11

module Casein
  class QuanHeGiaDinhsController < Casein::CaseinController
  
    ## optional filters for defining usage according to Casein::Users access_levels
    # before_filter :needs_admin, :except => [:action1, :action2]
    # before_filter :needs_admin_or_current_user, :only => [:action1, :action2]
  
    def index
      @casein_page_title = 'Quan he gia dinhs'
  		@quan_he_gia_dinhs = QuanHeGiaDinh.paginate :page => params[:page]
    end
  
    def show
      @casein_page_title = 'View quan he gia dinh'
      @quan_he_gia_dinh = QuanHeGiaDinh.find params[:id]
    end
 
    def new
      @casein_page_title = 'Add a new quan he gia dinh'
    	@quan_he_gia_dinh = QuanHeGiaDinh.new
    end

    def create
      @quan_he_gia_dinh = QuanHeGiaDinh.new params[:quan_he_gia_dinh]
    
      if @quan_he_gia_dinh.save
        flash[:notice] = 'Quan he gia dinh created'
        redirect_to casein_quan_he_gia_dinhs_path
      else
        flash.now[:warning] = 'There were problems when trying to create a new quan he gia dinh'
        render :action => :new
      end
    end
  
    def update
      @casein_page_title = 'Update quan he gia dinh'
      
      @quan_he_gia_dinh = QuanHeGiaDinh.find params[:id]
    
      if @quan_he_gia_dinh.update_attributes params[:quan_he_gia_dinh]
        flash[:notice] = 'Quan he gia dinh has been updated'
        redirect_to casein_quan_he_gia_dinhs_path
      else
        flash.now[:warning] = 'There were problems when trying to update this quan he gia dinh'
        render :action => :show
      end
    end
 
    def destroy
      @quan_he_gia_dinh = QuanHeGiaDinh.find params[:id]

      @quan_he_gia_dinh.destroy
      flash[:notice] = 'Quan he gia dinh has been deleted'
      redirect_to casein_quan_he_gia_dinhs_path
    end
  
  end
end