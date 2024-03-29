# Scaffolding generated by Casein v.3.1.11

module Casein
  class QuaTrinhCongTacsController < Casein::CaseinController
  
    ## optional filters for defining usage according to Casein::Users access_levels
    # before_filter :needs_admin, :except => [:action1, :action2]
    # before_filter :needs_admin_or_current_user, :only => [:action1, :action2]
=begin      
    def index
      @casein_page_title = Param.get_param_value "qua_trinh_cong_tac_index_page_titile"
  		#@qua_trinh_cong_tacs = QuaTrinhCongTac.paginate :page => params[:page]
      search_value = params["keyword"]
      if search_value != nil
        @qua_trinh_cong_tacs = QuaTrinhCongTac.search(search_value).paginate :per_page => 10, :page => params[:page],:order=> :can_bo_thong_tin_id
        @qua_trinh_cong_tacs_xls = QuaTrinhCongTac.search(search_value)
        if @qua_trinh_cong_tacs.count == 0
          flash.now[:warning] = Param.get_param_value("searching_has_no_result")
          @qua_trinh_cong_tacs = QuaTrinhCongTac.paginate :page => params[:page], :per_page => 10, :order=> :can_bo_thong_tin_id
          @qua_trinh_cong_tacs_xls = QuaTrinhCongTac.all
        else
          flash.now[:notice] = "#{Param.get_param_value("number_searching_result")} #{@qua_trinh_cong_tacs.count}"
        end
      else
        @qua_trinh_cong_tacs = QuaTrinhCongTac.paginate :page => params[:page], :per_page => 10,:order=> :can_bo_thong_tin_id
        @qua_trinh_cong_tacs_xls = QuaTrinhCongTac.all
      end

      respond_to do |format|
        format.html
        format.xls {
          can_bo = Spreadsheet::Workbook.new
          list = can_bo.create_worksheet :name => 'Danh sach Can Bo - Qua Trinh Cong Tac'
          list.row(0).concat %w{Ma_Can_Bo Ho_va_Ten Don_Vi Chu_Vu Thoi_Gian_Bat_Dau Thoi_Gian_Ket_Thuc}
          @qua_trinh_cong_tacs_xls.each_with_index { |canbo, i|
            list.row(i+1).push canbo.can_bo_thong_tin.ma_cb, canbo.can_bo_thong_tin.ho_ten, canbo.don_vi.ten_don_vi,canbo.chuc_vu.ten_chuc_vu,canbo.thoi_gian_bat_dau, canbo.thoi_gian_ket_thuc
          }
          header_format = Spreadsheet::Format.new :color => :green, :weight => :bold
          list.row(0).default_format = header_format
          #output to blob object
          blob = StringIO.new("")
          can_bo.write blob
          #respond with blob object as a file
          send_data blob.string, :type => :xls, :filename => "Danh_Sach_Can_Bo_Qua_Trinh_Cong_tac.xls"
        }
      end

    end
=end
     def index
      search_value = params["keyword"]
      view = 10
      don_vi = 0
      page = params[:page] ||= 1

      if params["num_view"].to_s != ""
        #must be a number
        if params["num_view"].match(/^\d+$/)
          #must be greater than 0 
          if params["num_view"].to_i > 0
            #set view value for pagination
            view = params["num_view"].to_i
          end
        end
      end

      if params[:don_vi]
        don_vi = params[:don_vi].to_i if params[:don_vi].match(/^\d+$/)
      end

      order = ""
      if params["order_by"].to_s != ""
        order = params["order_by"]
        #ignore the invalid values for order queries
        if order.split(":").last != "desc" && order.split(":").count > 1
          order = ""
        else
          #convert to correct format
          #param values has been submited include colon symbol
          #e.g: order by query desc
          order = order.gsub(':', ' ')
        end
      end

      #set conditions for paginate to filter records, it's base on don_vi parameter
      paginate_conditions = ""
      paginate_conditions = ['don_vi_id = ?', don_vi] if don_vi != 0

      @can_bos = CanBoThongTin.select("id, ma_cb, ho_ten, ngay_sinh, don_vi_id, chuc_vu_id, loai_lao_dong_id").search(search_value, don_vi).paginate :page => page, :per_page => view, :conditions => paginate_conditions
    end

    def details
       ma_cb = params[:ma_cb]
      can_bo_thong_tin = CanBoThongTin.find_by_ma_cb(ma_cb)
      if can_bo_thong_tin
        @can_bo_thong_tin = can_bo_thong_tin
        @qua_trinh_cong_tacs =  QuaTrinhCongTac.find_all_by_can_bo_thong_tin_id(can_bo_thong_tin.id)
      else
        render_404
      end
    end

    def show
      @casein_page_title = Param.get_param_value "qua_trinh_cong_tac_show_page_titile"
      @qua_trinh_cong_tac = QuaTrinhCongTac.find params[:id]

    end
    
    def edit
      @casein_page_title = Param.get_param_value "qua_trinh_cong_tac_edit_page_titile"
      @qua_trinh_cong_tac = QuaTrinhCongTac.find params[:id]
      @qua_trinh_cong_tac.so_quyet_dinh = @qua_trinh_cong_tac.quyet_dinh.so_qd
    end

    def new
      @casein_page_title = Param.get_param_value "qua_trinh_cong_tac_new_page_titile"
    	@qua_trinh_cong_tac = QuaTrinhCongTac.new
      if params[:ma_cb]
        cb = CanBoThongTin.find_by_ma_cb(params[:ma_cb])
        if cb
          @qua_trinh_cong_tac.can_bo_thong_tin_id = cb.id
          @is_edited = true
        end
      end
    end

    def create
      @qua_trinh_cong_tac = QuaTrinhCongTac.new params[:qua_trinh_cong_tac]
      quyet_dinh = QuyetDinh.find_by_so_qd(@qua_trinh_cong_tac.so_quyet_dinh)
      if quyet_dinh
        @qua_trinh_cong_tac.quyet_dinh_id = quyet_dinh.id

        qua_trinh_last = QuaTrinhCongTac.get_last(@qua_trinh_cong_tac.can_bo_thong_tin_id)
        unless qua_trinh_last.thoi_gian_ket_thuc
            thoi_gian_kt = @qua_trinh_cong_tac.thoi_gian_bat_dau
            qua_trinh_last.update_attribute(:thoi_gian_ket_thuc, thoi_gian_kt)
          
        end

        if @qua_trinh_cong_tac.save
          p = CanBoThongTin.find(@qua_trinh_cong_tac.can_bo_thong_tin_id)
          if p
            p.update_attribute(:chuc_vu_id, @qua_trinh_cong_tac.chuc_vu_id)
            p.update_attribute(:don_vi_id, @qua_trinh_cong_tac.don_vi_id)
          end

          flash[:notice] = Param.get_param_value("adding_success")
          redirect_to details_casein_qua_trinh_cong_tacs_path(:ma_cb => @qua_trinh_cong_tac.can_bo_thong_tin.ma_cb)
        else
          flash.now[:warning] = Param.get_param_value("adding_false")
          render :action => :new
        end
      else
         flash.now[:warning] = Param.get_param_value("adding_false")
          render :action => :new
      end
    end
  
    def update
      @casein_page_title = Param.get_param_value "qua_trinh_cong_tac_update_page_titile"
      
      @qua_trinh_cong_tac = QuaTrinhCongTac.find params[:id]
    
      quyetdinh = QuyetDinh.find_by_so_qd(params[:qua_trinh_cong_tac][:so_quyet_dinh])
        if quyetdinh 
          @qua_trinh_cong_tac.update_attribute(:quyet_dinh_id, quyetdinh.id)
        end
        
      if @qua_trinh_cong_tac.update_attributes params[:qua_trinh_cong_tac]
        last = QuaTrinhCongTac.get_last(params[:qua_trinh_cong_tac][:can_bo_thong_tin_id])
        if last.id == @qua_trinh_cong_tac.id
          p = CanBoThongTin.find(@qua_trinh_cong_tac.can_bo_thong_tin_id)
          if p
            p.update_attribute(:chuc_vu_id, @qua_trinh_cong_tac.chuc_vu_id)
            p.update_attribute(:don_vi_id, @qua_trinh_cong_tac.don_vi_id)
          end
        end

        flash[:notice] = Param.get_param_value("updating_success")
        redirect_to details_casein_qua_trinh_cong_tacs_path(:ma_cb => @qua_trinh_cong_tac.can_bo_thong_tin.ma_cb)
      else
        flash.now[:warning] = Param.get_param_value("updating_false")
        render :action => :show
      end
    end
 
    def destroy
      @qua_trinh_cong_tac = QuaTrinhCongTac.find params[:id]

      @qua_trinh_cong_tac.destroy
      flash[:notice] = Param.get_param_value("deleting_success")
      redirect_to casein_qua_trinh_cong_tacs_path
    end

    def import_from_excel
      @casein_page_title = Param.get_param_value("qua_trinh_cong_tac_import_from_excel_page_title")
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
        p = QuaTrinhCongTac.new
        canbo = CanBoThongTin.find_by_ma_cb(row[0].to_i.to_s)
        if canbo
          p.can_bo_thong_tin_id = canbo.id
          p.thoi_gian_bat_dau = row[4].to_date
          p.thoi_gian_ket_thuc = row[5].to_date
          dv = DonVi.find_by_ten_don_vi(row[2].to_s)
          if dv
            p.don_vi_id = dv.id
          end
          cv = ChucVu.find_by_ten_chuc_vu(row[3].to_s)
          if cv
            p.chuc_vu_id = cv.id
          end
          if p.valid?
            @commit += 1
            p.save
          else
            @wrong += 1
            @errors["#{@counter + 1}"] = "CB.#{row[0].to_i.to_s} - #{row[1].to_s}"

          end
        else
          @wrong += 1
          @errors["#{@counter + 1}"] = "CB.#{row[0].to_i.to_s} - #{row[1].to_s}"
        end
      end
      book.io.close
      if @wrong == 0
        flash[:notice] = "#{Param.get_param_value "import_success"} | #{Param.get_param_value "commit"}: #{@commit}/#{@counter} | #{Param.get_param_value "wrong"}: #{@wrong}"
        file.remove!
        redirect_to casein_qua_trinh_cong_tacs_path
      else
        flash[:notice] = "#{Param.get_param_value "import_success"} | #{Param.get_param_value "commit"}: #{@commit}/#{@counter} | #{Param.get_param_value "wrong"}: #{@wrong}"
        file.remove!
        render :action => 'show_result', :errors => @errors
      end

      else #if :excel_file is null
        flash[:warning] = Param.get_param_value ("let_choose_file_now")
        redirect_to import_from_excel_casein_qua_trinh_cong_tacs_path
      end

    end

    def show_result
      @casein_page_title = Param.get_param_value("can_bo_cong_tac_show_result_page_title")
      @errors = Hash.new
      @errors = params[:errors]
      respond_to do |format|
        format.html
        format.json {head :no_content}
      end
    end
  end
end