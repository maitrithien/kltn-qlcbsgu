# Scaffolding generated by Casein v.3.1.11

module Casein
  class LoaiDonVisController < Casein::CaseinController
  
    ## optional filters for defining usage according to Casein::Users access_levels
    # before_filter :needs_admin, :except => [:action1, :action2]
    # before_filter :needs_admin_or_current_user, :only => [:action1, :action2]
  
    def index
      @casein_page_title = 'Loai don vis'
  		@loai_don_vis = LoaiDonVi.paginate :page => params[:page]
    end
  
    def show
      @casein_page_title = 'View loai don vi'
      @loai_don_vi = LoaiDonVi.find params[:id]
    end
 
    def new
      @casein_page_title = 'Add a new loai don vi'
    	@loai_don_vi = LoaiDonVi.new
    end

    def create
      @loai_don_vi = LoaiDonVi.new params[:loai_don_vi]
    
      if @loai_don_vi.save
        flash[:notice] = 'Loai don vi created'
        redirect_to casein_loai_don_vis_path
      else
        flash.now[:warning] = 'There were problems when trying to create a new loai don vi'
        render :action => :new
      end
    end
  
    def update
      @casein_page_title = 'Update loai don vi'
      
      @loai_don_vi = LoaiDonVi.find params[:id]
    
      if @loai_don_vi.update_attributes params[:loai_don_vi]
        flash[:notice] = 'Loai don vi has been updated'
        redirect_to casein_loai_don_vis_path
      else
        flash.now[:warning] = 'There were problems when trying to update this loai don vi'
        render :action => :show
      end
    end
 
    def destroy
      @loai_don_vi = LoaiDonVi.find params[:id]

      @loai_don_vi.destroy
      flash[:notice] = 'Loai don vi has been deleted'
      redirect_to casein_loai_don_vis_path
    end
  
  end
end