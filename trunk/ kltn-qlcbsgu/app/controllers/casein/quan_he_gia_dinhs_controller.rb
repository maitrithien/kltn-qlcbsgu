# Scaffolding generated by Casein v.3.1.11

module Casein
  class QuanHeGiaDinhsController < Casein::CaseinController
  
    ## optional filters for defining usage according to Casein::Users access_levels
    # before_filter :needs_admin, :except => [:action1, :action2]
    # before_filter :needs_admin_or_current_user, :only => [:action1, :action2]
  
    def index
      @casein_page_title = Param.get_param_value "quan_he_gia_dinh_index_page_title"
  		@quan_he_gia_dinhs = QuanHeGiaDinh.paginate :page => params[:page], :per_page => 10

      @quan_he_gia_dinhs_xls = QuanHeGiaDinh.all
      respond_to do |format|
        format.html
        format.xls{
          quan_he = Spreadsheet::Workbook.new
          list = quan_he.create_worksheet :name => 'Danh sach quan he than nhan'
          list.row(0).concat %w{Ten_quan_he Ghi_chu}
          @quan_he_gia_dinhs_xls.each_with_index { |h, i| list.row(i+1).push h.ten_quan_he, h.ghi_chu}
          header_format = Spreadsheet::Format.new :color => :green, :weight => :bold
          list.row(0).default_format = header_format
          #output to blob object
          blob = StringIO.new("")
          quan_he.write blob
          #respond with blob object as a file
          send_data blob.string, :type => :xls, :filename => "Danh_sach_quan_he_than_nhan.xls"
        }
      end
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

    def import_from_excel
      @casein_page_title = Param.get_param_value("quan_he_gia_dinh_import_from_excel_page_title")
    end

    def parse_save_from_excel
      if params[:excel_file]
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
          p = QuanHeGiaDinh.new
          p.ten_quan_he = row[0].to_s
          p.ghi_chu = row[1].to_s
          if p.valid?
            @commit += 1
            p.save
          else
            @errors["#{@counter + 1}"] = "#{row[0]}"
            @wrong += 1
          end
        end
        book.io.close
        if @wrong == 0
          flash[:notice] = "#{Param.get_param_value "import_success"} | #{Param.get_param_value "commit"}: #{@commit}/#{@counter} | #{Param.get_param_value "wrong"}: #{@wrong}"
          file.remove!
          redirect_to casein_quan_he_gia_dinhs_path
        else
          flash[:notice] = "#{Param.get_param_value "import_success"} | #{Param.get_param_value "commit"}: #{@commit}/#{@counter} | #{Param.get_param_value "wrong"}: #{@wrong}"
          file.remove!
          render :action => 'show_result', :errors => @errors
        end

      else #if :excel_file is null
        flash[:warning] = Param.get_param_value ("let_choose_file_now")
        redirect_to import_from_excel_casein_quan_he_gia_dinhs_path
      end
    end


    def show_result
      @casein_page_title = Param.get_param_value("quan_he_gia_dinh_show_result_page_title")
      @errors = Hash.new
      @errors = params[:errors]
      respond_to do |format|
        format.html
        format.json {head :no_content}
      end
    end
  
  end
end