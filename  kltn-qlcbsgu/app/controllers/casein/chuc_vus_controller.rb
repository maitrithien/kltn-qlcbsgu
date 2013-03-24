# Scaffolding generated by Casein v.3.1.11

module Casein
  class ChucVusController < Casein::CaseinController
  
    ## optional filters for defining usage according to Casein::Users access_levels
    # before_filter :needs_admin, :except => [:action1, :action2]
    # before_filter :needs_admin_or_current_user, :only => [:action1, :action2]
  
    def index
      @casein_page_title = 'Chuc vus'
  		@chuc_vus = ChucVu.paginate :page => params[:page]
      @chuc_vus_xls = ChucVu.all
      respond_to do |format|
        format.html
        format.xls{
          chuc_vu = Spreadsheet::Workbook.new
          list = chuc_vu.create_worksheet :name => 'Danh sach Chuc Vu'
          list.row(0).concat %w{Ten_Chuc_Vu He_So_Phu_cap Ghi_Chu}
          @chuc_vus_xls.each_with_index { |ct, i|
            list.row(i+1).push(ct.ten_chuc_vu, ct.he_so_phu_cap ,ct.ghi_chu)
          }

          header_format = Spreadsheet::Format.new :color => :green, :weight => :bold
          list.row(0).default_format = header_format
          #output to blob object
          blob = StringIO.new("")
          chuc_vu.write blob
          #respond with blob object as a file
          send_data blob.string, :type => :xls, :filename => "Danh_Sach_Chuc_vu.xls"
        }
      end
    end
  
    def show
      @casein_page_title = 'View chuc vu'
      @chuc_vu = ChucVu.find params[:id]
    end
 
    def new
      @casein_page_title = 'Add a new chuc vu'
    	@chuc_vu = ChucVu.new
    end

    def create
      @chuc_vu = ChucVu.new params[:chuc_vu]
    
      if @chuc_vu.save
        flash[:notice] = Param.get_param_value("adding_success")
        redirect_to casein_chuc_vus_path
      else
        flash.now[:warning] = Param.get_param_value("deleting_false")
        render :action => :new
      end
    end
  
    def update
      @casein_page_title = 'Update chuc vu'
      
      @chuc_vu = ChucVu.find params[:id]
    
      if @chuc_vu.update_attributes params[:chuc_vu]
        flash[:notice] = Param.get_param_value("updating_success")
        redirect_to casein_chuc_vus_path
      else
        flash.now[:warning] = Param.get_param_value("updating_false")
        render :action => :show
      end
    end
 
    def destroy
      @chuc_vu = ChucVu.find params[:id]

      @chuc_vu.destroy
      flash[:notice] = Param.get_param_value("deleting_success")
      redirect_to casein_chuc_vus_path
    end
    def import_from_excel
      @casein_page_title = Param.get_param_value("chuc_vu_import_from_excel_page_title")
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
        p = ChucVu.new
        p.ten_chuc_vu = row[0].to_s
        p.he_so_phu_cap =  row[1].to_s
        p.ghi_chu = row[2].to_s
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
        redirect_to casein_chuc_vus_path
      else
        flash[:notice] = "#{Param.get_param_value "import_success"} | #{Param.get_param_value "commit"}: #{@commit}/#{@counter} | #{Param.get_param_value "wrong"}: #{@wrong}"
        file.remove!
        render :action => 'show_result', :errors => @errors
      end

    end

    def show_result
      @casein_page_title = Param.get_param_value("chuc_vu_show_result_page_title")
      @errors = Hash.new
      @errors = params[:errors]
      respond_to do |format|
        format.html
        format.json {head :no_content}
      end
    end
  end
end