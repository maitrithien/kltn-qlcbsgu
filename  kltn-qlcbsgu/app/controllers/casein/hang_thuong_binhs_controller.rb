# Scaffolding generated by Casein v.3.1.11

module Casein
  class HangThuongBinhsController < Casein::CaseinController
  
    ## optional filters for defining usage according to Casein::Users access_levels
    # before_filter :needs_admin, :except => [:action1, :action2]
    # before_filter :needs_admin_or_current_user, :only => [:action1, :action2]
  
    def index
      @casein_page_title = 'Hang thuong binhs'
      @hang_thuong_binh_xls = HangThuongBinh.all
  		@hang_thuong_binhs = HangThuongBinh.paginate :page => params[:page]
      respond_to do |format|
        format.html
        format.xls{
          hang_thuong_binh = Spreadsheet::Workbook.new
          list = hang_thuong_binh.create_worksheet :name => 'Danh sach Hang Thuong Binh'
          list.row(0).concat %w{Ti_Le_thuong_tat Ghi_chu}
          @hang_thuong_binh_xls.each_with_index { |ct, i|
            list.row(i+1).push(ct.ti_le_thuong_tat, ct.ghi_chu)
          }

          header_format = Spreadsheet::Format.new :color => :green, :weight => :bold
          list.row(0).default_format = header_format
          #output to blob object
          blob = StringIO.new("")
          hang_thuong_binh.write blob
          #respond with blob object as a file
          send_data blob.string, :type => :xls, :filename => "Danh_Sach_Hang_Thuong_binh.xls"
        }
      end
    end
  
    def show
      @casein_page_title = 'View hang thuong binh'
      @hang_thuong_binh = HangThuongBinh.find params[:id]
    end
 
    def new
      @casein_page_title = 'Add a new hang thuong binh'
    	@hang_thuong_binh = HangThuongBinh.new
    end

    def create
      @hang_thuong_binh = HangThuongBinh.new params[:hang_thuong_binh]
    
      if @hang_thuong_binh.save
        flash[:notice] = 'Hang thuong binh created'
        redirect_to casein_hang_thuong_binhs_path
      else
        flash.now[:warning] = 'There were problems when trying to create a new hang thuong binh'
        render :action => :new
      end
    end
  
    def update
      @casein_page_title = 'Update hang thuong binh'
      
      @hang_thuong_binh = HangThuongBinh.find params[:id]
    
      if @hang_thuong_binh.update_attributes params[:hang_thuong_binh]
        flash[:notice] = 'Hang thuong binh has been updated'
        redirect_to casein_hang_thuong_binhs_path
      else
        flash.now[:warning] = 'There were problems when trying to update this hang thuong binh'
        render :action => :show
      end
    end
 
    def destroy
      @hang_thuong_binh = HangThuongBinh.find params[:id]

      @hang_thuong_binh.destroy
      flash[:notice] = 'Hang thuong binh has been deleted'
      redirect_to casein_hang_thuong_binhs_path
    end

    def import_from_excel
      @casein_page_title = Param.get_param_value("hang_thuong_binh_import_from_excel_page_title")
    end

    def parse_save_from_excel
      file_path = params[:excel_file]
      file = XlsUploader.new
      file.store!(file_path)

      book = Spreadsheet.open "public/#{file.store_path}"

      sheet = book.worksheet 0  # first sheet in the spreadsheet file will be used

      @errors = Hash.new
      @counter = 0
      @commit = 0
      @wrong = 0
      sheet.each 1 do |row|
        @counter += 1
        p = HangThuongBinh.new
        p.ti_le_thuong_tat = row[0].to_s
        p.ghi_chu =  row[1].to_s
        if p.valid?
          @commit += 1
          p.save
        else
          @wrong += 1
          @errors["#{@counter + 1}"] = "CB.#{row[0].to_i.to_s} - #{row[1].to_s}"
        end
      end
      book.io.close
      if @wrong == 0
        flash[:notice] = "#{Param.get_param_value "import_success"} | #{Param.get_param_value "commit"}: #{@commit}/#{@counter} | #{Param.get_param_value "wrong"}: #{@wrong}"
        file.remove!
        redirect_to casein_hang_thuong_binhs_path
      else
        flash[:notice] = "#{Param.get_param_value "import_success"} | #{Param.get_param_value "commit"}: #{@commit}/#{@counter} | #{Param.get_param_value "wrong"}: #{@wrong}"
        file.remove!
        render :action => 'show_result', :errors => @errors
      end

    end

    def show_result
      @casein_page_title = Param.get_param_value("hang_thuong_binh_show_result_page_title")
      @errors = Hash.new
      @errors = params[:errors]
      respond_to do |format|
        format.html
        format.json {head :no_content}
      end
    end
  end
end