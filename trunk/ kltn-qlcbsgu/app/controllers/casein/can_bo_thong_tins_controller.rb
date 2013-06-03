# Scaffolding generated by Casein v.3.1.11

module Casein
  class CanBoThongTinsController < Casein::CaseinController
  
    ## optional filters for defining usage according to Casein::Users access_levels
    # before_filter :needs_admin, :except => [:action1, :action2]
    # before_filter :needs_admin_or_current_user, :only => [:action1, :action2]

  
    def index
      @casein_page_title = Param.get_param_value("can_bo_thong_tin_index_page_title")
      search_value = params["keyword"]
      view = 10
      don_vi = 0

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

      if search_value != nil
        @can_bo_thong_tins = CanBoThongTin.search(search_value, don_vi).paginate(:per_page => view, :page => params[:page], :conditions => paginate_conditions, :order => order)
        @can_bo_thong_tins_xls = CanBoThongTin.search(search_value, don_vi)
        if @can_bo_thong_tins.count == 0
          flash.now[:warning] = Param.get_param_value("searching_has_no_result")
          @can_bo_thong_tins = CanBoThongTin.paginate :page => params[:page], :per_page => view, :conditions => paginate_conditions, :order => order
          @can_bo_thong_tins_xls = CanBoThongTin.all
        else
          flash.now[:notice] = "#{Param.get_param_value("number_searching_result")} #{@can_bo_thong_tins.count}"
        end
      else
        @can_bo_thong_tins = CanBoThongTin.paginate :page => params[:page], :conditions => paginate_conditions, :per_page => view, :order => order
        @can_bo_thong_tins_xls = CanBoThongTin.all
      end
      
      respond_to do |format|
        format.html
        format.xls {
          can_bo = Spreadsheet::Workbook.new
          list = can_bo.create_worksheet :name => 'Danh sach can bo'
          list.row(0).concat %w{Ma_CB Ho_va_Ten Ten_goi_khac Gioi_tinh Ngay_Sinh Noi_sinh Que_quan Dan_toc Ton_giao Noi_dang_ky_HKTT Noi_o_hien_nay So_BNXH So_CMND Ngay_cap_CMND}
          @can_bo_thong_tins_xls.each_with_index { |canbo, i|
            if canbo.gioi_tinh
              gioi_tinh = 'Nam'
            else
              gioi_tinh = Param.get_param_value 'Nu'
            end
            list.row(i+1).push canbo.ma_cb, canbo.ho_ten, canbo.ten_goi_khac, gioi_tinh, canbo.ngay_sinh, canbo.noi_sinh, canbo.que_quan, canbo.dan_toc, canbo.ton_giao, canbo.noi_dang_ky_ho_khau_thuong_tru, canbo.noi_o_hien_nay, canbo.so_BHXH, canbo.so_cmnd, canbo.ngay_cap_cmnd
          }
          header_format = Spreadsheet::Format.new :color => :green, :weight => :bold
          list.row(0).default_format = header_format
          #output to blob object
          blob = StringIO.new("")
          can_bo.write blob
          #respond with blob object as a file
          send_data blob.string, :type => :xls, :filename => "Danh_sach_can_bo_vien_chuc_#{Time.now.to_i.to_s}.xls"
        }
      end
    end

    def edit
      @casein_page_title = Param.get_param_value("can_bo_thong_tin_edit_page_title")
      @can_bo_thong_tin = CanBoThongTin.find params[:id]
      @can_bo_thong_tin.so_quyet_dinh = @can_bo_thong_tin.quyet_dinh.so_qd
    end

    def show

      @lich_su_bac_luongs = []
      @can_bo_trinh_do = nil
      @than_nhans = []
      @qua_trinh_cong_tacs = []
      @can_bo_cong_tac = nil

      @casein_page_title = Param.get_param_value("can_bo_thong_tin_show_page_title")
      @can_bo_thong_tin = CanBoThongTin.find params[:id]
      than_nhans = ThanNhan.find_all_by_can_bo_thong_tin_id params[:id]
      lich_su_bac_luongs = LichSuBacLuong.find_all_by_can_bo_thong_tin_id params[:id]  
      qua_trinh_cong_tacs = QuaTrinhCongTac.find_all_by_can_bo_thong_tin_id params[:id]
      trinh_do = CanBoTrinhDo.find_by_can_bo_thong_tin_id params[:id]
      can_bo_cong_tac = CanBoCongTac.find_by_can_bo_thong_tin_id params[:id]

      if than_nhans.count > 0
        @than_nhans = than_nhans
      end
      if lich_su_bac_luongs.count > 0
        @lich_su_bac_luongs = lich_su_bac_luongs
      end
      if qua_trinh_cong_tacs.count > 0
        @qua_trinh_cong_tacs = qua_trinh_cong_tacs
      end
      if trinh_do
        @can_bo_trinh_do = trinh_do
      end
      if can_bo_cong_tac
        @can_bo_cong_tac = can_bo_cong_tac
      end

      respond_to do |format|
        format.html
        format.xls{
          book = Spreadsheet::Workbook.new
          none_format = Spreadsheet::Format.new
          sheet = book.create_worksheet :name => "So yeu ly lich"
          sheet.row(0)[1] = "#{Param.get_param_value("so_yeu_ly_lich")}"

          i = 2
          #write can_bo_thong_tin info
          @can_bo_thong_tin.attributes.each do |attr_name, attr_value|

            #format gioi_tinh to text value
            if attr_name == 'gioi_tinh'
              if attr_value
                attr_value = "Nam"
              else
                attr_value = ""
              end
            end

            if attr_name != 'is_deleted' && attr_name != 'tep_tin_dinh_kem' && attr_name != 'id' && attr_name != 'bac_luong_id' && attr_name != 'hinh_anh' && attr_name != 'created_at' && attr_name != 'updated_at'
              i = i + 1
              sheet.row(i)[1] = "#{Param.get_param_value"#{attr_name}"}"
              sheet.row(i)[2] = attr_value
            end

            if attr_name == 'bac_luong_id'
              if attr_value
                bac_luong = BacLuong.find(attr_value)
                if bac_luong
                  i = i + 1
                  sheet.row(i)[1] = "#{Param.get_param_value"ngach"}"
                  sheet.row(i)[2] = bac_luong.ngach.ten_ngach
                  i = i + 1
                  sheet.row(i)[1] = "#{Param.get_param_value"ma_ngach"}"
                  sheet.row(i)[2] = bac_luong.ngach.ma_ngach
                  i = i + 1
                  sheet.row(i)[1] = "#{Param.get_param_value"bac_luong"}"
                  sheet.row(i)[2] = bac_luong.bac
                  i = i + 1
                  sheet.row(i)[1] = "#{Param.get_param_value"he_so_luong"}"
                  if bac_luong.vuot_khung
                    sheet.row(i)[2] = "VK #{bac_luong.he_so_luong}%"
                  else
                    sheet.row(i)[2] = bac_luong.he_so_luong
                  end


                end
              end

            end


          end  #end can_bo_thong_tin loop function

          if @can_bo_cong_tac
            i = i + 1
            sheet.row(i)[1] = "#{Param.get_param_value"don_vi_tuyen_dung"}"
            if  @can_bo_cong_tac.don_vi_id
              sheet.row(i)[2] = @can_bo_cong_tac.don_vi.ten_don_vi
            end
            i = i + 1
            sheet.row(i)[1] = "#{Param.get_param_value"nghe_nghiep_truoc_tuyen_dung"}"
            sheet.row(i)[2] =  @can_bo_cong_tac.nghe_nghiep_truoc_tuyen_dung
            i = i + 1
            sheet.row(i)[1] = "#{Param.get_param_value"cong_viec"}"
            sheet.row(i)[2] = @can_bo_cong_tac.cong_viec_chinh_duoc_giao
            i = i + 1
            sheet.row(i)[1] = "#{Param.get_param_value"so_truong"}"
            sheet.row(i)[2] = @can_bo_cong_tac.so_truong_cong_tac
            i = i + 1
            sheet.row(i)[1] = "#{Param.get_param_value"ngay_bat_dau_lam_viec"}"
            if @can_bo_cong_tac.ngay_bat_dau_lam_viec
              sheet.row(i)[2] = @can_bo_cong_tac.ngay_bat_dau_lam_viec.strftime("%d/%m/%Y")
            end

          end
          if @can_bo_trinh_do
            i = i + 1
            #write can_bo_thong_tin info
            sheet.row(i)[1] = Param.get_param_value("trinh_do_pho_thong")
            sheet.row(i)[2] = @can_bo_trinh_do.trinh_do_gd_pho_thong
            i = i + 1
            if  @can_bo_trinh_do.hoc_ham_id
              sheet.row(i)[1] = Param.get_param_value("hoc_ham")
              sheet.row(i)[2] = @can_bo_trinh_do.hoc_ham.ten_hoc_ham
              i = i + 1
            end

            if  @can_bo_trinh_do.hoc_vi_id
              sheet.row(i)[1] = Param.get_param_value("hoc_vi")
              sheet.row(i)[2] = @can_bo_trinh_do.hoc_vi.ten_hoc_vi
              i = i + 1
            end

            if  @can_bo_trinh_do.chuyen_nganh_id
              sheet.row(i)[1] = Param.get_param_value("trinh_do_chuyen_mon")
              sheet.row(i)[2] = "#{@can_bo_trinh_do.trinh_do_chuyen_mon.trinh_do} #{@can_bo_trinh_do.chuyen_nganh.ten_chuyen_nganh}"
              i = i + 1
            end

            if  @can_bo_trinh_do.ly_luan_chinh_tri_id
              sheet.row(i)[1] = Param.get_param_value("ly_luan_chinh_tri")
              sheet.row(i)[2] = @can_bo_trinh_do.ly_luan_chinh_tri.trinh_do
              i = i + 1
            end

            if  @can_bo_trinh_do.quan_ly_nha_nuoc_id
              sheet.row(i)[1] = Param.get_param_value("quan_ly_nha_nuoc")
              sheet.row(i)[2] = @can_bo_trinh_do.quan_ly_nha_nuoc.trinh_do
              i = i + 1
            end

            if  @can_bo_trinh_do.ngoai_ngu_id
              sheet.row(i)[1] = Param.get_param_value("ngoai_ngu")
              sheet.row(i)[2] = "#{@can_bo_trinh_do.ngoai_ngu.ten_ngoai_ngu} #{@can_bo_trinh_do.trinh_do_ngoai_ngu}"
              i = i + 1
            end

            if  @can_bo_trinh_do.trinh_do_tin_hoc
              sheet.row(i)[1] = Param.get_param_value("tin_hoc")
              sheet.row(i)[2] = "#{@can_bo_trinh_do.trinh_do_tin_hoc}"
              i = i + 1
            end

          end



          #format display layout
          sheet.merge_cells(0, 1, 1, 2)
          header_format = Spreadsheet::Format.new :color => :green, :weight => :bold, :size => 16, :align => :center, :vertical_align => :center, :horizontal_align => :center
          sheet.row(0).default_format = header_format
          sheet.column(1).default_format = Spreadsheet::Format.new :weight => :bold, :align => :left, :text_wrap => true, :vertical_align => :center
          sheet.column(1).width = 20
          sheet.column(2).default_format = Spreadsheet::Format.new :align => :left, :vertical_align => :center
          sheet.column(2).width = 50

          sheet_second = book.create_worksheet :name => "Than nhan"
          #write than_nhan info
          i = 2
          sheet_second.row(0)[1] = "#{Param.get_param_value("thong_tin_than_nhan")}"
          sheet_second.merge_cells(0, 1, 0, 4)
          sheet_second.row(0).default_format = Spreadsheet::Format.new :color => :green, :weight => :bold, :size => 12, :align => :center
          sheet_second.row(i)[1] = "#{Param.get_param_value("moi_quan_he")}"
          sheet_second.row(i)[2] = "#{Param.get_param_value("ho_ten")}"
          sheet_second.row(i)[3] = "#{Param.get_param_value("nam_sinh")}"
          sheet_second.row(i)[4] = "#{Param.get_param_value("nghe_nghiep")}"
          sheet_second.row(i).default_format = Spreadsheet::Format.new :color => :green, :weight => :bold, :align => :top, :text_wrap => true
          if @than_nhans.count > 0
            @than_nhans.each do |than_nhan|
              i = i + 1
              sheet_second.row(i)[1] = than_nhan.quan_he_gia_dinh.ten_quan_he
              sheet_second.row(i)[2] = than_nhan.ho_ten
              sheet_second.row(i)[3] = than_nhan.nam_sinh
              sheet_second.row(i)[4] = than_nhan.nghe_nghiep
              sheet_second.row(i).default_format =  Spreadsheet::Format.new :align => :top, :text_wrap => true
            end
            sheet_second.column(1).width = 15
            sheet_second.column(2).width = 20
            sheet_second.column(2).width = 15
            sheet_second.column(4).width = 30
          end

          sheet_third = book.create_worksheet :name => "Qua trinh cong tac"
          #write than_nhan info
          i = 2
          sheet_third.row(0)[1] = "#{Param.get_param_value("qua_trinh_cong_tac")}"
          sheet_third.merge_cells(0, 1, 0, 4)
          sheet_third.row(0).default_format = Spreadsheet::Format.new :color => :green, :weight => :bold, :size => 12, :align => :center
          sheet_third.row(i)[1] = "#{Param.get_param_value("don_vi")}"
          sheet_third.row(i)[2] = "#{Param.get_param_value("chuc_vu")}"
          sheet_third.row(i)[3] = "#{Param.get_param_value("thoi_gian_bat_dau")}"
          sheet_third.row(i)[4] = "#{Param.get_param_value("thoi_gian_chuyen_cong_tac")}"
          sheet_third.row(i).default_format = Spreadsheet::Format.new :color => :green, :weight => :bold, :align => :top, :text_wrap => true
          if @qua_trinh_cong_tacs.count > 0
            @qua_trinh_cong_tacs.each do |qua_trinh_cong_tac|
              i = i + 1
              if qua_trinh_cong_tac.don_vi_id
                sheet_third.row(i)[1] = qua_trinh_cong_tac.don_vi.ten_don_vi
              end
              if qua_trinh_cong_tac.chuc_vu_id
                sheet_third.row(i)[2] = qua_trinh_cong_tac.chuc_vu.ten_chuc_vu
              end
              if qua_trinh_cong_tac.thoi_gian_bat_dau
                sheet_third.row(i)[3] = qua_trinh_cong_tac.thoi_gian_bat_dau.strftime("%d/%m/%Y")
              end
              if qua_trinh_cong_tac.thoi_gian_ket_thuc
                sheet_third.row(i)[4] = qua_trinh_cong_tac.thoi_gian_ket_thuc.strftime("%d/%m/%Y")
              end
              sheet_third.row(i).default_format =  Spreadsheet::Format.new :align => :top, :text_wrap => true
            end
            sheet_third.column(1).width = 20
            sheet_third.column(2).width = 15
            sheet_third.column(2).width = 15
            sheet_third.column(4).width = 15
          end

          sheet_fourth = book.create_worksheet :name => "Lich su thay doi bac luong"
          #write than_nhan info
          i = 2
          sheet_fourth.row(0)[1] = "#{Param.get_param_value("lich_su_bac_luong")}"
          sheet_fourth.merge_cells(0, 1, 0, 4)
          sheet_fourth.row(0).default_format = Spreadsheet::Format.new :color => :green, :weight => :bold, :size => 12, :align => :center
          sheet_fourth.row(i)[1] = "#{Param.get_param_value("ngach")}"
          sheet_fourth.row(i)[2] = "#{Param.get_param_value("bac")}"
          sheet_fourth.row(i)[3] = "#{Param.get_param_value("ngay_thay_doi_bac")}"
          sheet_fourth.row(i)[4] = "#{Param.get_param_value("ghi_chu")}"
          sheet_fourth.row(i).default_format = Spreadsheet::Format.new :color => :green, :weight => :bold, :align => :top, :text_wrap => true
          if @lich_su_bac_luongs.count > 0
            @lich_su_bac_luongs.each do |lich_su_bac_luong|
              i = i + 1
              if lich_su_bac_luong.bac_luong_id
                if lich_su_bac_luong.bac_luong.ngach_id
                  sheet_fourth.row(i)[1] = lich_su_bac_luong.bac_luong.ngach.ten_ngach
                end
                sheet_fourth.row(i)[2] = lich_su_bac_luong.bac_luong.bac
              end
              if lich_su_bac_luong.ngay_thay_doi_bac
                sheet_fourth.row(i)[3] = lich_su_bac_luong.ngay_thay_doi_bac.strftime("%d/%m/%Y")
              end
              sheet_fourth.row(i)[4] = lich_su_bac_luong.ghi_chu
              sheet_fourth.row(i).default_format =  Spreadsheet::Format.new :align => :top, :text_wrap => true
            end
            sheet_fourth.column(1).width = 20
            sheet_fourth.column(2).width = 10
            sheet_fourth.column(2).width = 20
            sheet_fourth.column(4).width = 20
          end

          #output to blob object
          blob = StringIO.new("")
          book.write blob
          #respond with blob object as a file
          send_data blob.string, :type => :xls, :filename => "so_yeu_ly_lich_can_bo_#{@can_bo_thong_tin.ma_cb}_#{@can_bo_thong_tin.ho_ten.to_s.chars.select(&:ascii_only?).join.gsub!(' ', '_')}.xls"
        }
      end

    end
 
    def new
      @casein_page_title = Param.get_param_value("can_bo_thong_tin_new_page_title")
    	@can_bo_thong_tin = CanBoThongTin.new
    end

    def create
      @can_bo_thong_tin = CanBoThongTin.new params[:can_bo_thong_tin]
      #image uploader
      my_image = params[:can_bo_thong_tin][:hinh_anh]
      image_uploader = ImageUploader.new
      image_uploader.store!(my_image)
      image_uploader.retrieve_from_store!('my_image.png')
      #file uploader
      my_file = params[:can_bo_thong_tin][:tep_tin_dinh_kem]
      file_uploader = FileUploader.new
      file_uploader.store!(my_file)
      file_uploader.retrieve_from_store!('my_file.doc')

      if params[:can_bo_thong_tin][:ten_goi_khac] == ""
        params[:can_bo_thong_tin][:ten_goi_khac] = params[:can_bo_thong_tin][:ho_ten]
      end

      quyet_dinh = QuyetDinh.find_by_so_qd(@can_bo_thong_tin.so_quyet_dinh)
      if quyet_dinh
        @can_bo_thong_tin.quyet_dinh_id = quyet_dinh.id
        if @can_bo_thong_tin.save
          flash[:notice] = Param.get_param_value("adding_success")
          redirect_to casein_can_bo_thong_tins_path
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
      @casein_page_title = Param.get_param_value("can_bo_thong_tin_update_page_title")

      #image uploader
      my_image = params[:can_bo_thong_tin][:hinh_anh]
      image_uploader = ImageUploader.new
      image_uploader.store!(my_image)
      #file uploader
      my_file = params[:can_bo_thong_tin][:tep_tin_dinh_kem]
      file_uploader = FileUploader.new
      file_uploader.store!(my_file)

      if params[:can_bo_thong_tin][:ten_goi_khac] == ""
        params[:can_bo_thong_tin][:ten_goi_khac] = params[:can_bo_thong_tin][:ho_ten]
      end

      @can_bo_thong_tin = CanBoThongTin.find params[:id]

      quyetdinh = QuyetDinh.find_by_so_qd(params[:can_bo_thong_tin][:so_quyet_dinh])
        if quyetdinh 
          @can_bo_thong_tin.update_attribute(:quyet_dinh_id, quyetdinh.id)
        end
        

      if @can_bo_thong_tin.update_attributes params[:can_bo_thong_tin]

        flash[:notice] = Param.get_param_value("updating_success")
        redirect_to casein_can_bo_thong_tin_path(@can_bo_thong_tin)
      else
        flash.now[:warning] = Param.get_param_value("updating_false")
        render :action => :edit
      end
    end
 
    def destroy
      @can_bo_thong_tin = CanBoThongTin.find params[:id]

      @can_bo_thong_tin.update_attributes(:is_deleted => true)
      flash[:notice] = Param.get_param_value("deleting_success")
      redirect_to casein_can_bo_thong_tins_path
    end

    def custom_export_data
      @casein_page_title = Param.get_param_value("can_bo_thong_tin_custom_export_data_page_title")
    end

    def get_and_export_to_excel
      @casein_page_title = Param.get_param_value("can_bo_thong_tin_get_and_export_to_excel_page_title")
      @can_bo_thong_tins = CanBoThongTin.all
      
      respond_to do |format|
        format.html
        format.xls {
          can_bo = Spreadsheet::Workbook.new
          list = can_bo.create_worksheet :name => 'Danh sach can bo'
		      last = 4    
          @can_bo_thong_tins.each_with_index {|cb, index|
            i = 1
            index = index + 3
            list.row(2)[i] = "Ma can bo"
            list.row(index)[i] = cb.ma_cb

            if params['ho_ten'].to_s != ""
                i = i + 1
                list.row(2)[i] = "Ho va Ten"
                list.row(index)[i] = cb.ho_ten
             
            end
            if params['ten_goi_khac'].to_s != ""
              i = i + 1
              list.row(2)[i] = "Ten goi khac"
              list.row(index)[i] = cb.ten_goi_khac
            end
            if params["ngay_sinh"].to_s != ""
              i = i + 1
              list.row(2)[i] = "Ngay sinh"
              list.row(index)[i] = cb.ngay_sinh
            end
            if params["gioi_tinh"].to_s != ""
              i = i + 1
              list.row(2)[i] = "Gioi tinh"
              if cb.gioi_tinh
                list.row(index)[i] = "Nam"
              else
                list.row(index)[i] = ""
              end
            end
            if params["noi_sinh"].to_s == "true"
              i = i + 1
              list.row(2)[i] = "Noi sinh"
              list.row(index)[i] = cb.noi_sinh
            end
            if params["que_quan"].to_s == "true"
              i = i + 1
              list.row(2)[i] = "Que quan"
              list.row(index)[i] = cb.que_quan
            end
            if params["dan_toc"].to_s == "true"
              i = i + 1
              list.row(2)[i] = "Dan toc"
              list.row(index)[i] = cb.dan_toc
            end
            if params["ton_giao"].to_s == "true"
              i = i + 1
              list.row(2)[i] = "Ton giao"
              list.row(index)[i] = cb.ton_giao
            end
            if params["noi_o_hien_nay"].to_s == "true"
              i = i + 1
              list.row(2)[i] = "Noi o hien nay"
              list.row(index)[i] = cb.noi_o_hien_nay
            end
            if params["noi_dang_ky_ho_khau_thuong_tru"].to_s == "true"
              i = i + 1
              list.row(2)[i] = "Noi dang ky ho khau thuong tru"
              list.row(index)[i] = cb.noi_dang_ky_ho_khau_thuong_tru
            end
            if params["so_cmnd"].to_s == "true"
              i = i + 1
              list.row(2)[i] = "So CMND"
              list.row(index)[i] = cb.so_cmnd
            end
            if params["ngay_cap_cmnd"].to_s == "true"
              i = i + 1
              list.row(2)[i] = "Ngay cap CMND"
              list.row(index)[i] = cb.ngay_cap_cmnd
            end
            if params["so_BHXH"].to_s == "true"
              i = i + 1
              list.row(2)[i] = "So so BHXH"
              list.row(index)[i] = cb.so_BHXH 
            end
            if params["ngach"].to_s == "true"
              i = i + 1
              list.row(2)[i] = "Ngach cong chuc"
              if cb.bac_luong_id
                bac_luong = BacLuong.find(cb.bac_luong_id)
                if bac_luong
                  if Ngach.find(bac_luong.ngach_id)
                    list.row(index)[i] = bac_luong.ngach.ten_ngach
                  end
                end
              end 
            end
            if params["ma_ngach"].to_s == "true"
              i = i + 1
              list.row(2)[i] = "Ma ngach"
              if cb.bac_luong_id
                bac_luong = BacLuong.find(cb.bac_luong_id)
                if bac_luong
                  if Ngach.find(bac_luong.ngach_id)
                    list.row(index)[i] = bac_luong.ngach.ma_ngach
                  end
                end
              end 
            end
            if params["bac_luong"].to_s == "true"
              i = i + 1
              list.row(2)[i] = "Bac luong"
              if cb.bac_luong_id
                bac_luong = BacLuong.find(cb.bac_luong_id)
                if bac_luong
                  list.row(index)[i] = bac_luong.bac
                end
              end
            end
            if params["he_so"].to_s == "true"
              i = i + 1
              list.row(2)[i] = "He so luong"
              if cb.bac_luong_id
                bac_luong = BacLuong.find(cb.bac_luong_id)
                if bac_luong
                  list.row(index)[i] = bac_luong.he_so_luong
                end
              end
            end
            if params["don_vi"].to_s == "true"
              i = i + 1
              list.row(2)[i] = "Don vi tuyen dung"
              can_bo_cong_tac = CanBoCongTac.find_by_can_bo_thong_tin_id(cb.id)
              if can_bo_cong_tac
                if can_bo_cong_tac.don_vi_id
                  don_vi = DonVi.find(can_bo_cong_tac.don_vi_id)
                  if don_vi
                    list.row(index)[i] = can_bo_cong_tac.don_vi.ten_don_vi
                  end
                end
              end
            end
            if params["nghe_nghiep"].to_s == "true"
              i = i + 1
              list.row(2)[i] = "Nghe nghiep truoc tuyen dung"
              can_bo_cong_tac = CanBoCongTac.find_by_can_bo_thong_tin_id(cb.id)
              if can_bo_cong_tac
                list.row(index)[i] = can_bo_cong_tac.nghe_nghiep_truoc_tuyen_dung
              end
            end
            if params["cong_viec_chinh_duoc_giao"].to_s == "true"
              i = i + 1
              list.row(2)[i] = "Cong viec chinh duoc giao"
              can_bo_cong_tac = CanBoCongTac.find_by_can_bo_thong_tin_id(cb.id)
              if can_bo_cong_tac
                list.row(index)[i] = can_bo_cong_tac.cong_viec_chinh_duoc_giao
              end
            end
            if params["so_truong_cong_tac"].to_s == "true"
              i = i + 1
              list.row(2)[i] = "So truong cong tac"
              can_bo_cong_tac = CanBoCongTac.find_by_can_bo_thong_tin_id(cb.id)
              if can_bo_cong_tac
                list.row(index)[i] = can_bo_cong_tac.cong_viec_chinh_duoc_giao
              end
            end
            if params["ngay_bat_dau_lam_viec"].to_s == "true"
              i = i + 1
              list.row(2)[i] = "Ngay bat dau lam viec"
              can_bo_cong_tac = CanBoCongTac.find_by_can_bo_thong_tin_id(cb.id)
              if can_bo_cong_tac
                list.row(index)[i] = can_bo_cong_tac.ngay_bat_dau_lam_viec
              end
            end
            if params["trinh_do_pho_thong"].to_s == "true"
              i = i + 1
              list.row(2)[i] = "Trinh do giao duc pho thong"
              can_bo_trinh_do = CanBoTrinhDo.find_by_can_bo_thong_tin_id(cb.id)
              if can_bo_trinh_do
                list.row(index)[i] = can_bo_trinh_do.trinh_do_gd_pho_thong
              end
            end
            if params["trinh_do_chuyen_mon"].to_s == "true"
              i = i + 1
              list.row(2)[i] = "Trinh do chuyen mon cao nhat"
              can_bo_trinh_do = CanBoTrinhDo.find_by_can_bo_thong_tin_id(cb.id)
              if can_bo_trinh_do
                if can_bo_trinh_do.trinh_do_chuyen_mon_id
                  trinh_do_chuyen_mon = TrinhDoChuyenMon.find(can_bo_trinh_do.trinh_do_chuyen_mon_id)
                  if trinh_do_chuyen_mon
                    list.row(index)[i] = can_bo_trinh_do.trinh_do_chuyen_mon.trinh_do
                  end
                end
              end
            end
            if params["hoc_ham"].to_s == "true"
              i = i + 1
              list.row(2)[i] = "Hoc ham"
              can_bo_trinh_do = CanBoTrinhDo.find_by_can_bo_thong_tin_id(cb.id)
              if can_bo_trinh_do
                if can_bo_trinh_do.hoc_ham_id
                  hoc_ham = HocHam.find(can_bo_trinh_do.hoc_ham_id)
                  if hoc_ham
                    list.row(index)[i] = hoc_ham.ten_hoc_ham
                  end
                end
              end
            end
            if params["hoc_vi"].to_s == "true"
              i = i + 1
              list.row(2)[i] = "Hoc vi"
              can_bo_trinh_do = CanBoTrinhDo.find_by_can_bo_thong_tin_id(cb.id)
              if can_bo_trinh_do
                if can_bo_trinh_do.hoc_vi_id
                  hoc_vi = HocVi.find(can_bo_trinh_do.hoc_vi_id)
                  if hoc_vi
                    list.row(index)[i] = hoc_vi.ten_hoc_vi
                  end
                end
              end
            end
            if params["ly_luan_chinh_tri"].to_s == "true"
              i = i + 1
              list.row(2)[i] = "Trinh do ly luan chinh tri"
              can_bo_trinh_do = CanBoTrinhDo.find_by_can_bo_thong_tin_id(cb.id)
              if can_bo_trinh_do
                if can_bo_trinh_do.ly_luan_chinh_tri_id
                  ly_luan_chinh_tri = LyLuanChinhTri.find(can_bo_trinh_do.ly_luan_chinh_tri_id)
                  if ly_luan_chinh_tri
                    list.row(index)[i] = ly_luan_chinh_tri.trinh_do
                  end
                end
              end
            end
            if params["quan_ly_nha_nuoc"].to_s == "true"
              i = i + 1
              list.row(2)[i] = "Trinh do quan ly nha nuoc"
              can_bo_trinh_do = CanBoTrinhDo.find_by_can_bo_thong_tin_id(cb.id)
              if can_bo_trinh_do
                if can_bo_trinh_do.quan_ly_nha_nuoc_id
                  quan_ly_nha_nuoc = QuanLyNhaNuoc.find(can_bo_trinh_do.quan_ly_nha_nuoc_id)
                  if quan_ly_nha_nuoc
                    list.row(index)[i] = quan_ly_nha_nuoc.trinh_do
                  end
                end
              end
            end
            if params["ngoai_ngu"].to_s == "true"
              i = i + 1
              list.row(2)[i] = "Ngoai ngu"
              can_bo_trinh_do = CanBoTrinhDo.find_by_can_bo_thong_tin_id(cb.id)
              if can_bo_trinh_do
                if can_bo_trinh_do.ngoai_ngu_id
                  ngoai_ngu = NgoaiNgu.find(can_bo_trinh_do.ngoai_ngu_id)
                  if ngoai_ngu
                    list.row(index)[i] = "#{ngoai_ngu.ten_ngoai_ngu} #{can_bo_trinh_do.trinh_do_ngoai_ngu}"
                  end
                end
              end
            end
            if params["tin_hoc"].to_s == "true"
              i = i + 1
              list.row(2)[i] = "Tin hoc"
              can_bo_trinh_do = CanBoTrinhDo.find_by_can_bo_thong_tin_id(cb.id)
              if can_bo_trinh_do
                list.row(index)[i] = can_bo_trinh_do.trinh_do_tin_hoc
              end
            end
			     last = i
          }
          list.row(0)[0] = "DANH SACH CAN BO CONG CHUC"
          list.merge_cells(0, 0, 1, last)
          list.row(0).default_format = Spreadsheet::Format.new :color => :green, :weight => :bold, :align => :center, :size => 13
		      list.row(2).default_format = Spreadsheet::Format.new :color => :green, :weight => :bold
			
          #format columns width
          1.upto(last) do |index|
            list.column(index).width = 20
          end
		  list.row(2)[0] = "STT"
		  list.column(0).width = 5
		  1.upto(@can_bo_thong_tins.count) do |stt|
			list.row(stt + 2)[0] = stt
		  end

          #output to blob object
          blob = StringIO.new("")
          can_bo.write blob
          #respond with blob object as a file
          send_data blob.string, :type => :xls, :filename => "Danh_sach_can_bo_#{Time.now.to_i.to_s}.xls"
        }
      end
      
    end

    def import_from_excel
      @casein_page_title = Param.get_param_value("can_bo_thong_tin_import_from_excel_page_title")
    end

    def parse_save_from_excel
      if params[:excel_file]
      file_path = params[:excel_file]
      file = XlsUploader.new
      file.store!(file_path)

      book = Spreadsheet.open "public/#{file.store_path}"

      sheet = book.worksheet 0  # first sheet in the spreadsheet file will be used

      columns = []
      if params[:custom]
        columns = [params[:ma_cb].to_i - 1, params[:ho_ten].to_i - 1, params[:ten_goi_khac].to_i - 1, params[:gioi_tinh].to_i - 1, params[:ngay_sinh].to_i - 1, params[:noi_sinh].to_i - 1, params[:que_quan].to_i - 1, params[:dan_toc].to_i - 1, params[:ton_giao].to_i - 1, params[:noi_dang_ky_ho_khau_thuong_tru].to_i - 1, params[:noi_o_hien_nay].to_i - 1, params[:so_BHXH].to_i - 1, params[:so_cmnd].to_i - 1, params[:ngay_cap_cmnd].to_i] - 1
      else
        columns = Array(0..13)
      end
      @errors = Hash.new
      @counter = 0
      @commit = 0
      @wrong = 0
      sheet.each 1 do |row|
        @counter += 1
        p = CanBoThongTin.new
        p.ma_cb = row[columns[0]].to_i
        p.ho_ten = row[columns[1]].to_s
        p.ten_goi_khac = row[columns[2]].to_s
        gioi_tinh = row[columns[3]].to_s.chars.select(&:ascii_only?).join #remove unicode and lowercase
        if gioi_tinh.upcase == 'NAM'
          p.gioi_tinh = true
        else
          p.gioi_tinh = false
        end
        p.ngay_sinh = row[columns[4]].to_date
        p.noi_sinh = row[columns[5]].to_s
        p.que_quan = row[columns[6]].to_s
        p.dan_toc = row[columns[7]].to_s
        p.ton_giao = row[columns[8]].to_s
        p.noi_dang_ky_ho_khau_thuong_tru = row[columns[9]].to_s
        p.noi_o_hien_nay = row[columns[10]].to_s
        p.so_BHXH = row[columns[11]].to_s
        p.so_cmnd = row[columns[12]].to_s
        p.ngay_cap_cmnd = row[columns[13]].to_date
        if params["allow_null_ten_goi_khac"].to_s !="1"
          p.ten_goi_khac = ""
        end
        if params["allow_null_so_BHXH"].to_s !="1"
          p.so_BHXH = ""
        end
        if params["allow_null_ngay_cap_cmnd"].to_s !="1"
          p.ngay_cap_cmnd = Time.now
        end

        if p.valid?
          @commit += 1
          p.save
        else
          @errors["#{@counter + 1}"] = "#{p.ma_cb} - #{p.ho_ten}"
          @wrong += 1
        end
      end
      book.io.close
      if @wrong == 0
        flash[:notice] = "#{Param.get_param_value "import_success"} | #{Param.get_param_value "commit"}: #{@commit}/#{@counter} | #{Param.get_param_value "wrong"}: #{@wrong}"
        file.remove!
        redirect_to casein_can_bo_thong_tins_path
      else
        flash[:notice] = "#{Param.get_param_value "import_success"} | #{Param.get_param_value "commit"}: #{@commit}/#{@counter} | #{Param.get_param_value "wrong"}: #{@wrong}"
        file.remove!
        render :action => 'show_result', :errors => @errors
      end

      else #if :excel_file is null
        flash[:warning] = Param.get_param_value ("let_choose_file_now")
        redirect_to import_from_excel_casein_can_bo_thong_tins_path
      end

    end

    def advance_search
      @casein_page_title = Param.get_param_value("can_bo_thong_tin_advance_search_page_title")
      search_advance_req = params["search_advance_req"]
      if search_advance_req!= nil and search_advance_req.length>0
        @can_bo_thong_tin = CanBoThongTin.new params[:can_bo_thong_tin]
        options = {}
        #gioi_tinh to hash
        if params[:can_bo_thong_tin][:search_by_gioi_tinh].to_s != "all"
          options = options.merge(:gioi_tinh =>  params[:can_bo_thong_tin][:search_by_gioi_tinh].to_s)
        end
         #each attribute to hash, except gioi_tinh, ngay_sinh,
         @can_bo_thong_tin.attributes.each do |attr_name, attr_value|
             if attr_value.to_s.length>0 && attr_name !='gioi_tinh' && attr_name !='is_deleted'
                options = options.merge(attr_name =>attr_value)
             end
         end
        if @can_bo_thong_tin.don_vi_id.to_s.length>0
          options = options.merge(:don_vi_id =>  @can_bo_thong_tin.don_vi_id)
        end
        if @can_bo_thong_tin.trinh_do_chuyen_mon_id.to_s.length>0
          options = options.merge(:trinh_do_chuyen_mon_id =>  @can_bo_thong_tin.trinh_do_chuyen_mon_id)
        end
        if @can_bo_thong_tin.chuc_vu_id.to_s.length>0
          options = options.merge(:chuc_vu_id =>  @can_bo_thong_tin.chuc_vu_id)
        end
        if @can_bo_thong_tin.ngach_id.to_s.length>0
          options = options.merge(:ngach_id =>  @can_bo_thong_tin.ngach_id)
        end


        # set sql excute query is_deleted = false (only get employee not deleted)
        options = options.merge(:is_deleted =>  false)

        @can_bo_thong_tins = CanBoThongTin.search_advance(options).paginate(:per_page => 10, :page => params[:page])
        @has_result = true

        if @can_bo_thong_tins.count == 0
          flash.now[:warning] = Param.get_param_value("searching_has_no_result")
          @has_result = false
        else
          flash.now[:notice] = "#{Param.get_param_value("number_searching_result")} #{@can_bo_thong_tins.count}"
        end
      else
        @can_bo_thong_tin = CanBoThongTin.new
      end
    end


    def statistic
      @casein_page_title = Param.get_param_value("can_bo_thong_tin_thong_ke_page_title")
      statistic_req = params["statistic_req"]

      hash_params = {
                      :don_vi_id => params["don_vi_id"] || [], 
                      :hoc_ham_id => params["hoc_ham_id"] || [],
                      :hoc_vi_id => params["hoc_vi_id"] || [],
                      :ngach_id => params["ngach_id"] || [],
                      :gioi_tinh => params["gioi_tinh"],
                      :dan_toc => params["dan_toc"],
                      :nam_sinh_tu => params["nam_sinh_tu"],
                      :nam_sinh_den => params["nam_sinh_den"],
                      :dang_vien => params["dang_vien"],
                      :nam_cong_tac => params["nam_cong_tac"],
                      :gia_dinh_chinh_sach => params["gia_dinh_chinh_sach"]
                    }
      if statistic_req
        @can_bo_thong_tins = CanBoThongTin.statistic(hash_params)
        
        if @can_bo_thong_tins.count>0
          @can_bo_thong_tins = @can_bo_thong_tins.paginate :page=>params[:page], :order => "don_vi_id", :per_page => 10
          @has_result = true
          @counter = @can_bo_thong_tins.count
          flash.now[:notice] = "#{Param.get_param_value("number_searching_result")} #{@can_bo_thong_tins.count}"
        else
          flash.now[:warning] = Param.get_param_value("searching_has_no_result")
          @has_result = false
        end
      end
    end


    def statistic_by_age
      can_bo_thong_tins = 
      range_of_age = params[:range] || "0"
      ranges = range_of_age.split(";").map { |r| Param.magick(r) }
      @hash = {}
      DonVi.all.each do |dv|
        group = {}
        ranges.map do |r|
          count = 0
          CanBoThongTin.find_all_by_don_vi_id(dv.id).each do |cb|
            if (r.include? cb.age)
              count += 1
            end
          end
          group.merge!({ "#{r}" => count})
        end
        @hash.merge!({ "#{dv.ten_don_vi}" => group})
      end

      respond_to do |f|
        f.html
        f.json { render :json => @hash }
      end

    end

    def show_result
      @casein_page_title = Param.get_param_value("can_bo_thong_tin_show_result_page_title")
      @errors = Hash.new
      @errors = params[:errors]
      respond_to do |format|
        format.html
        format.json {head :no_content}
      end
    end

  end
end