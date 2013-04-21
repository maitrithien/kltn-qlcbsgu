# Scaffolding generated by Casein v.3.1.11

module Casein
  class QuyetDinhsController < Casein::CaseinController
  
    ## optional filters for defining usage according to Casein::Users access_levels
    # before_filter :needs_admin, :except => [:action1, :action2]
    # before_filter :needs_admin_or_current_user, :only => [:action1, :action2]
  
    def index
      @casein_page_title = Param.get_param_value("quyet_dinh_index_page_title")
      search_value = params["keyword"]
      if search_value != nil
        @quyet_dinhs = QuyetDinh.search(search_value).paginate(:per_page => 10, :page => params[:page])
        @quyet_dinhs_xls = QuyetDinh.search(search_value)
        if @quyet_dinhs.count == 0
          flash.now[:warning] = Param.get_param_value("searching_has_no_result")
          @quyet_dinhs = QuyetDinh.paginate :page => params[:page], :per_page => 10
          @quyet_dinhs_xls = QuyetDinh.all
        else
          flash.now[:notice] = "#{Param.get_param_value("number_searching_result")} #{@quyet_dinhs.count}"
        end
      else
        @quyet_dinhs = QuyetDinh.paginate :page => params[:page], :per_page => 10
        @quyet_dinhs_xls = QuyetDinh.all
      end

      respond_to do |format|
        format.html
        format.xls{
          quyet_dinh = Spreadsheet::Workbook.new
          list = quyet_dinh.create_worksheet :name => 'Danh sach quyet dinh'
          list.row(0).concat %w{So_quyet_dinh Ngay_ra_quyet_dinh Noi_dung Ghi_chu}
          loai_qd = ""
          @quyet_dinhs_xls.each_with_index { |h, i|
            if h.loai_quyet_dinh_id
              loai_qd = h.loai_quyet_dinh.ten_loai_qd
            end
            list.row(i+1).push h.so_qd, loai_qd, h.ngay_ra_qd, h.noi_dung_tom_tat
          }
          header_format = Spreadsheet::Format.new :color => :green, :weight => :bold
          list.row(0).default_format = header_format
          #output to blob object
          blob = StringIO.new("")
          quyet_dinh.write blob
          #respond with blob object as a file
          send_data blob.string, :type => :xls, :filename => "Danh_Sach_Quyet_dinh.xls"
        }
      end
    end
  
    def show
      @casein_page_title = Param.get_param_value("quyet_dinh_show_page_title")
      @quyet_dinh = QuyetDinh.find params[:id]
    end
 
    def new
      @casein_page_title = Param.get_param_value("quyet_dinh_new_page_title")
    	@quyet_dinh = QuyetDinh.new
    end

    def create
      @quyet_dinh = QuyetDinh.new params[:quyet_dinh]
    
      if @quyet_dinh.save
        flash[:notice] = Param.get_param_value("adding_success")
        redirect_to casein_quyet_dinhs_path
      else
        flash.now[:warning] = Param.get_param_value("adding_false")
        render :action => :new
      end
    end
  
    def update
      @casein_page_title = Param.get_param_value("quyet_dinh_update_page_title")
      
      @quyet_dinh = QuyetDinh.find params[:id]
    
      if @quyet_dinh.update_attributes params[:quyet_dinh]
        flash[:notice] = Param.get_param_value("updating_success")
        redirect_to casein_quyet_dinhs_path
      else
        flash.now[:warning] = Param.get_param_value("updating_false")
        render :action => :show
      end
    end
 
    def destroy
      @quyet_dinh = QuyetDinh.find params[:id]

      @quyet_dinh.destroy
      flash[:notice] = Param.get_param_value("deleting_success")
      redirect_to casein_quyet_dinhs_path
    end

    def import_from_excel
      @casein_page_title = Param.get_param_value("quyet_dinh_import_from_excel_page_title")
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
          p = QuyetDinh.new
          loai_qd = LoaiQuyetDinh.find_by_ten_loai_qd(row[1].to_s)

          if loai_qd
            p.loai_quyet_dinh_id = loai_qd.id
            p.so_qd = row[0].to_s
            p.ngay_ra_qd = Date.parse(row[2].to_s) rescue nil
            p.noi_dung_tom_tat = row[3].to_s
          end

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
          redirect_to casein_quyet_dinhs_path
        else
          flash[:notice] = "#{Param.get_param_value "import_success"} | #{Param.get_param_value "commit"}: #{@commit}/#{@counter} | #{Param.get_param_value "wrong"}: #{@wrong}"
          file.remove!
          render :action => 'show_result', :errors => @errors
        end

      else #if :excel_file is null
        flash[:warning] = Param.get_param_value ("let_choose_file_now")
        redirect_to import_from_excel_casein_quyet_dinhs_path
      end
    end


    def show_result
      @casein_page_title = Param.get_param_value("quyet_dinh_show_result_page_title")
      @errors = Hash.new
      @errors = params[:errors]
      respond_to do |format|
        format.html
        format.json {head :no_content}
      end
    end
  
  end
end