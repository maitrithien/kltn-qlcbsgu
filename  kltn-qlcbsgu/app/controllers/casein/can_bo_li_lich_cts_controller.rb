# Scaffolding generated by Casein v.3.1.11

module Casein
  class CanBoLiLichCtsController < Casein::CaseinController
  
    ## optional filters for defining usage according to Casein::Users access_levels
    # before_filter :needs_admin, :except => [:action1, :action2]
    # before_filter :needs_admin_or_current_user, :only => [:action1, :action2]
  
    def index
      @casein_page_title = Param.get_param_value("can_bo_li_lich_ct_index_page_title")
      search_value = params["keyword"]
      if search_value
        @can_bo_li_lich_cts = CanBoLiLichCt.search(search_value).paginate(:per_page => 10, :order => "can_bo_thong_tin_id", :page => params[:page])
        @can_bo_li_lich_cts_xls = CanBoLiLichCt.search(search_value)
        if @can_bo_li_lich_cts.count == 0
          flash.now[:warning] = Param.get_param_value("searching_has_no_result")
          @can_bo_li_lich_cts = CanBoLiLichCt.paginate( :page => params[:page], :per_page => 10, :order => "can_bo_thong_tin_id")
          @can_bo_li_lich_cts_xls = CanBoLiLichCt.all
        else
          flash.now[:notice] = "#{Param.get_param_value("number_searching_result")} #{@can_bo_li_lich_cts.count}"
        end
      else
        @can_bo_li_lich_cts = CanBoLiLichCt.paginate( :page => params[:page], :per_page => 10, :order => "can_bo_thong_tin_id")
        @can_bo_li_lich_cts_xls = CanBoLiLichCt.all
      end
      respond_to do |format|
        format.html
        format.xls{
          can_bo_li_lich = Spreadsheet::Workbook.new
          list = can_bo_li_lich.create_worksheet :name => 'Danh sach Li lich chinh tri can bo'
          list.row(0).concat %w{Ma_CB Ho_ten Ngay_vao_dang Ngay_nhap_ngu Ngay_xuat_ngu Quan_ham_cao_nhat Danh_hieu_duoc_phong_tang Thuong_binh Gia_dinh_chinh_sach}
          cap_bac = ""
          ti_le_thuong_tat = ""
          @can_bo_li_lich_cts_xls.each_with_index { |ct, i|
            if ct.cap_bac_quan_doi_id
              cap_bac = ct.cap_bac_quan_doi.ten_cap_bac
            end
            if ct.hang_thuong_binh_id
              ti_le_thuong_tat = ct.hang_thuong_binh.ti_le_thuong_tat
            end
            list.row(i+1).push(ct.can_bo_thong_tin.ma_cb, ct.can_bo_thong_tin.ho_ten, ct.ngay_vao_dang, ct.ngay_nhap_ngu, ct.ngay_xuat_ngu,cap_bac, ct.danh_hieu_duoc_phong_tang, ti_le_thuong_tat, ct.con_gia_dinh_chinh_sach)
          }

          header_format = Spreadsheet::Format.new :color => :green, :weight => :bold
          list.row(0).default_format = header_format
          #output to blob object
          blob = StringIO.new("")
          can_bo_li_lich.write blob
          #respond with blob object as a file
          send_data blob.string, :type => :xls, :filename => "Danh_Sach_Li_lich_chinh_tri.xls"
        }
      end
    end
  
    def show
      @casein_page_title =  Param.get_param_value("can_bo_li_lich_ct_show_page_title")
      @can_bo_li_lich_ct = CanBoLiLichCt.find params[:id]
      @can_bo_li_lich_ct.ho_ten_return = CanBoThongTin.find(@can_bo_li_lich_ct.can_bo_thong_tin_id).ho_ten
    end
    
    def edit
      @casein_page_title =  Param.get_param_value("can_bo_li_lich_ct_edit_page_title")
      @can_bo_li_lich_ct = CanBoLiLichCt.find params[:id]
    end

    def new
      @casein_page_title = Param.get_param_value("can_bo_li_lich_ct_new_page_title")
    	@can_bo_li_lich_ct = CanBoLiLichCt.new
    end

    def create
      @can_bo_li_lich_ct = CanBoLiLichCt.new params[:can_bo_li_lich_ct]
      if @can_bo_li_lich_ct.save
        flash[:notice] =  Param.get_param_value("adding_success");
        redirect_to casein_can_bo_li_lich_cts_path
      else
        flash.now[:warning] = Param.get_param_value("adding_false");
        render :action => :new
      end
    end
  
    def update
      @casein_page_title =  Param.get_param_value("can_bo_li_lich_ct_update_page_title")
      
      @can_bo_li_lich_ct = CanBoLiLichCt.find params[:id]

      if @can_bo_li_lich_ct.update_attributes params[:can_bo_li_lich_ct]
        flash[:notice] = Param.get_param_value("updating_success");
        redirect_to casein_can_bo_li_lich_cts_path
      else
        flash.now[:warning] = Param.get_param_value("updating_false");
        render :action => :show
      end
    end
 
    def destroy
      @can_bo_li_lich_ct = CanBoLiLichCt.find params[:id]

      @can_bo_li_lich_ct.destroy
      flash[:notice] = Param.get_param_value("deleting_success");
      redirect_to casein_can_bo_li_lich_cts_path
    end


    def import_from_excel
      @casein_page_title = Param.get_param_value("can_bo_li_lich_ct_import_from_excel_page_title")
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
        p = CanBoLiLichCt.new
        canbo = CanBoThongTin.find_by_ma_cb(row[0].to_i.to_s)
        if canbo
          p.can_bo_thong_tin_id = canbo.id
          p.ngay_vao_dang = row[2].to_date
          p.ngay_nhap_ngu = row[3].to_date
          p.ngay_xuat_ngu = row[4].to_date
          p.danh_hieu_duoc_phong_tang = row[6].to_s
          p.con_gia_dinh_chinh_sach= row[8].to_s

          qd = CapBacQuanDoi.find_by_ten_cap_bac(row[5].to_s)
          if qd
            p.cap_bac_quan_doi_id = qd.id
          end
          tb = HangThuongBinh.find_by_ti_le_thuong_tat(row[7].to_s)
          if tb
             p.hang_thuong_binh_id = tb.id
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
        redirect_to casein_can_bo_li_lich_cts_path
      else
        flash[:notice] = "#{Param.get_param_value "import_success"} | #{Param.get_param_value "commit"}: #{@commit}/#{@counter} | #{Param.get_param_value "wrong"}: #{@wrong}"
        file.remove!
        render :action => 'show_result', :errors => @errors
      end

      else #if :excel_file is null
        flash[:warning] = Param.get_param_value ("let_choose_file_now")
        redirect_to import_from_excel_casein_can_bo_li_lich_cts_path
      end

    end

    def show_result
      @casein_page_title = Param.get_param_value("can_bo_li_lich_ct_show_result_page_title")
      @errors = Hash.new
      @errors = params[:errors]
      respond_to do |format|
        format.html
        format.json {head :no_content}
      end
    end
  end
end