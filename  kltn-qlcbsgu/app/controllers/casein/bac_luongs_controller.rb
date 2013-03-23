# Scaffolding generated by Casein v.3.1.11

module Casein
  class BacLuongsController < Casein::CaseinController
  
    ## optional filters for defining usage according to Casein::Users access_levels
    # before_filter :needs_admin, :except => [:action1, :action2]
    # before_filter :needs_admin_or_current_user, :only => [:action1, :action2]
  
    def index
      @casein_page_title = Param.get_param_value "bac_luong_index_page_title"
  		@bac_luongs = BacLuong.paginate :page => params[:page], :order=> :ngach_id , :per_page => 8
    end
  
    def show
      @casein_page_title = Param.get_param_value "bac_luong_show_page_title"
      @bac_luong = BacLuong.find params[:id]

    end
 
    def new
      @casein_page_title = Param.get_param_value "bac_luong_new_page_title"
    	@bac_luong = BacLuong.new
    end

    def create

      @bac_luong = BacLuong.new params[:bac_luong]
      if params['vuot_khung'].to_s =="1"
        @bac_luong.vuot_khung = true
      end
      if BacLuong.check_exists @bac_luong.ngach_id, @bac_luong.bac
        flash.now[:warning] = "#{@bac_luong.ngach.ten_ngach} - B.#{@bac_luong.bac} #{Param.get_param_value "has_already_been_taken"}"
        render :action => :new
      else
        if @bac_luong.save
          flash[:notice] = Param.get_param_value("adding_success")
          redirect_to casein_bac_luongs_path
        else
          flash.now[:warning] = Param.get_param_value("adding_false")
          render :action => :new
        end
      end

    end
  
    def update
      @casein_page_title = Param.get_param_value "bac_luong_update_page_title"
      @bac_luong = BacLuong.find params[:id]
    
      if @bac_luong.update_attributes params[:bac_luong]
        flash[:notice] = Param.get_param_value("updating_success")
        redirect_to casein_bac_luongs_path
      else
        flash.now[:warning] = Param.get_param_value("updating_false")
        render :action => :show
      end
    end
 
    def destroy
      @bac_luong = BacLuong.find params[:id]

      @bac_luong.destroy
      flash[:notice] = Param.get_param_value("deleting_success")
      redirect_to casein_bac_luongs_path
    end
  
  end
end