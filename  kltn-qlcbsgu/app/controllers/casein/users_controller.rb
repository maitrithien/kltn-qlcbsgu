module Casein
  class UsersController < Casein::CaseinController

    unloadable
  
    before_filter :needs_admin, :except => [:show, :destroy, :update, :update_password]
    before_filter :needs_admin_or_current_user, :only => [:show, :destroy, :update, :update_password]
 
    def index
      @casein_page_title = Param.get_param_value("users_index_page_title")
    	@users = Casein::User.paginate :order => "login", :page => params[:page], :per_page => 10
    end
 
    def new
      @casein_page_title = Param.get_param_value("users_new_page_title")
    	@casein_user = Casein::User.new
    	@casein_user.time_zone = Rails.configuration.time_zone
    end
  
    def create
      @casein_user = Casein::User.new params[:casein_user]
    
      if @casein_user.save
        flash[:notice] = "#{Param.get_param_value("email_has_been_sent_to")} " + @casein_user.name
        redirect_to casein_users_path
      else
        flash.now[:warning] = "#{Param.get_param_value("adding_false")}"
        render :action => :new
      end
    end
  
    def show
    	@casein_user = Casein::User.find params[:id]
    	@casein_page_title = @casein_user.name + " | #{Param.get_param_value("users_show_page_title")}"
    end
 
    def update
      @casein_user = Casein::User.find params[:id]
      @casein_page_title = @casein_user.name + " | #{Param.get_param_value("users_update_page_title")}"

      if @casein_user.update_attributes params[:casein_user]
        flash[:notice] = @casein_user.name + " #{Param.get_param_value("has_been_updated")}"
      else
        flash.now[:warning] = Param.get_param_value("updating_false")
        render :action => :show
        return
      end
      
      if @session_user.is_admin?
        redirect_to casein_users_path
      else
        redirect_to :controller => :casein, :action => :index
      end
    end
 
    def update_password
      @casein_user = Casein::User.find params[:id]
      @casein_page_title = @casein_user.name + " | #{Param.get_param_value("users_update_password_page_title")}"
       
      if @casein_user.valid_password? params[:form_current_password]
        if @casein_user.update_attributes params[:casein_user]
          flash.now[:notice] =  Param.get_param_value("your_password_has_been_changed")
        else
          flash.now[:warning] = Param.get_param_value("change_password_false")
        end
      else
        flash.now[:warning] = Param.get_param_value("the_current_password_is_incorrect")
      end
      
      render :action => :show
    end
 
    def reset_password
      @casein_user = Casein::User.find params[:id]
      @casein_page_title = @casein_user.name + " | #{Param.get_param_value("users_reset_password_page_title")}"
       
      @casein_user.notify_of_new_password = true unless @casein_user.id == @session_user.id
      
      if @casein_user.update_attributes params[:casein_user]
        if @casein_user.id == @session_user.id
          flash.now[:notice] = Param.get_param_value("your_password_has_been_reset")
        else    
          flash.now[:notice] = "#{Param.get_param_value("password_has_been_reset")}. " + @casein_user.name + " #{Param.get_param_value("has_been_notified_by_email")}"
        end
        
      else
        flash.now[:warning] = Param.get_param_value("updating_false")
      end
      render :action => :show
    end
 
    def destroy
      user = Casein::User.find params[:id]
      if user.is_admin? == false || Casein::User.has_more_than_one_admin
        user.destroy
        flash[:notice] = user.name + " #{Param.get_param_value("has_been_deleted")}"
      end
      redirect_to casein_users_path
    end
 
  end
end