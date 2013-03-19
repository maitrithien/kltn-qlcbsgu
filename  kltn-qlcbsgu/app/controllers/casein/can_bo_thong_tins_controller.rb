# Scaffolding generated by Casein v.3.1.11

module Casein
  class CanBoThongTinsController < Casein::CaseinController
  
    ## optional filters for defining usage according to Casein::Users access_levels
    # before_filter :needs_admin, :except => [:action1, :action2]
    # before_filter :needs_admin_or_current_user, :only => [:action1, :action2]

  
    def index
      @casein_page_title = Param.get_param_value("can_bo_thong_tin_index_page_title")
      search_value = params["keyword"]
      if search_value != nil
        @can_bo_thong_tins = CanBoThongTin.search(search_value).paginate(:per_page => 10, :page => params[:page])
        @can_bo_thong_tins_xls = CanBoThongTin.search(search_value)
        if @can_bo_thong_tins.count == 0
          flash.now[:warning] = Param.get_param_value("searching_has_no_result")
          @can_bo_thong_tins = CanBoThongTin.paginate :page => params[:page], :per_page => 10
          @can_bo_thong_tins_xls = CanBoThongTin.all
        else
          flash.now[:notice] = "#{Param.get_param_value("number_searching_result")} #{@can_bo_thong_tins.count}"
        end
      else
        @can_bo_thong_tins = CanBoThongTin.paginate :page => params[:page], :per_page => 10
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
          send_data blob.string, :type => :xls, :filename => "Danh_Sach_CBVC_TT.xls"
        }
      end
    end

    def edit
      @casein_page_title = Param.get_param_value("can_bo_thong_tin_edit_page_title")
      @can_bo_thong_tin = CanBoThongTin.find params[:id]
    end

    def show
      @casein_page_title = Param.get_param_value("can_bo_thong_tin_show_page_title")
      @can_bo_thong_tin = CanBoThongTin.find params[:id]
      than_nhans = ThanNhan.find_all_by_can_bo_thong_tin_id params[:id]
      @than_nhans = []
      if than_nhans
        @than_nhans = than_nhans
      end

      trinh_do = CanBoTrinhDo.find_by_can_bo_thong_tin_id params[:id]
      @can_bo_trinh_do = nil
      if trinh_do
        @can_bo_trinh_do = trinh_do
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
                attr_value = "Nu"
              end
            end

            if attr_name != 'is_deleted' && attr_name != 'tep_tin_dinh_kem' && attr_name != 'id' && attr_name != 'hinh_anh' && attr_name != 'created_at' && attr_name != 'updated_at'
              i = i + 1
              sheet.row(i)[1] = "#{Param.get_param_value"#{attr_name}"}"
              sheet.row(i)[2] = attr_value
            end

          end  #end can_bo_thong_tin loop function
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
          i = 0
          if @than_nhans.count > 0
            @than_nhans.each do |than_nhan|
              i = i + 1
              sheet_second.row(i).push than_nhan.quan_he_gia_dinh.ten_quan_he, than_nhan.ho_ten, than_nhan.nam_sinh, than_nhan.nghe_nghiep
              sheet_second.row(i).set_format(i, none_format)
            end
          end



          #output to blob object
          blob = StringIO.new("")
          book.write blob
          #respond with blob object as a file
          send_data blob.string, :type => :xls, :filename => "so_yeu_ly_lich.xls"
        }
      end

    end
 
    def new
      @casein_page_title = Param.get_param_value("can_bo_thong_tin_new_title")
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
      if @can_bo_thong_tin.save
        flash[:notice] = Param.get_param_value("adding_success")
        redirect_to casein_can_bo_thong_tins_path
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

        if p.valid?
          @commit += 1
          p.save
        else
          @errors["#{@counter + 1}"] = p.errors
          @wrong += 1
        end
      end
      book.io.close
      if @wrong == 0
        flash[:notice] = "Successfully import!\r\nCommit: #{@commit}.\r\nWrong: #{@wrong}"
        file.remove!
        redirect_to casein_can_bo_thong_tins_path
      else
        flash[:notice] = "Successfully import!\r\nCommit: #{@commit}.\r\nWrong: #{@wrong}"
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
             if attr_value.to_s.length>0 && attr_name !='gioi_tinh' && attr_name !='ngay_sinh' && attr_name !='is_deleted'
                options = options.merge(attr_name =>attr_value)
             end
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