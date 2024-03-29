# Scaffolding generated by Casein v.3.1.11

module Casein
  class CanBoCongTacsController < Casein::CaseinController
  
    ## optional filters for defining usage according to Casein::Users access_levels
    # before_filter :needs_admin, :except => [:action1, :action2]
    # before_filter :needs_admin_or_current_user, :only => [:action1, :action2]
    #@can_bo_cong_tacs = CanBoCongTac.paginate :page => params[:page]
    def index
      @casein_page_title = Param.get_param_value "can_bo_cong_tac_index_page_title"
      search_value = params["keyword"]

      view = 10
      if params["num_view"].to_s != ""
        view = params["num_view"].to_i if params["num_view"].match(/^\d+$/)
      end
      order = "can_bo_thong_tin_id"
      if search_value != nil
        @can_bo_cong_tacs = CanBoCongTac.search(search_value).paginate(:per_page => view, :page => params[:page],:order=> order)
        @can_bo_cong_tacs_xls = CanBoCongTac.search(search_value)
        if @can_bo_cong_tacs.count == 0
          flash.now[:warning] = Param.get_param_value("searching_has_no_result")
          @can_bo_cong_tacs = CanBoCongTac.paginate :page => params[:page], :per_page => view, :order=> order
          @can_bo_cong_tacs_xls = CanBoCongTac.all
        else
          flash.now[:notice] = "#{Param.get_param_value("number_searching_result")} #{@can_bo_cong_tacs.count}"
        end
      else
        @can_bo_cong_tacs = CanBoCongTac.paginate :page => params[:page], :per_page => view,:order=> order
        @can_bo_cong_tacs_xls = CanBoCongTac.all
      end

      respond_to do |format|
        format.html
        format.xls {
          can_bo = Spreadsheet::Workbook.new
          list = can_bo.create_worksheet :name => 'Danh sach Can Bo - Cong Tac'
          list.row(0).concat %w{Ma_Can_bo Ho_va_Ten Don_Vi_Tuyen_Dung Nghe_Nghiep_Truoc_Tuyen_Dung Cong_Viec_Chinh_Duoc_Giao So_Truong_Cong_Tac Ngay_Bat_Dau_Lam_Viec Ghi_Chu}
          @can_bo_cong_tacs_xls.each_with_index { |canbo, i|

            list.row(i+1).push canbo.can_bo_thong_tin.ma_cb, canbo.can_bo_thong_tin.ho_ten, canbo.don_vi.ten_don_vi, canbo.nghe_nghiep_truoc_tuyen_dung, canbo.cong_viec_chinh_duoc_giao, canbo.so_truong_cong_tac, canbo.ngay_bat_dau_lam_viec, canbo.ghi_chu
          }
          header_format = Spreadsheet::Format.new :color => :green, :weight => :bold
          list.row(0).default_format = header_format
          #output to blob object
          blob = StringIO.new("")
          can_bo.write blob
          #respond with blob object as a file
          send_data blob.string, :type => :xls, :filename => "Danh_Sach_Can_Bo_Cong_tac.xls"
        }
      end


    end
  
    def show
      @casein_page_title = Param.get_param_value "can_bo_cong_tac_show_page_title"
      @can_bo_cong_tac = CanBoCongTac.find params[:id]
    end

    def edit
      @casein_page_title = Param.get_param_value "can_bo_cong_tac_edit_page_title"
      @can_bo_cong_tac = CanBoCongTac.find params[:id]
      @ma_cb = @can_bo_cong_tac.can_bo_thong_tin.ma_cb

    end
 
    def new
      @casein_page_title = Param.get_param_value "can_bo_cong_tac_new_page_title"
      @can_bo_cong_tac = CanBoCongTac.new
      if params[:ma_cb]
        cb = CanBoThongTin.find_by_ma_cb(params[:ma_cb])
        if cb
          @can_bo_cong_tac.can_bo_thong_tin_id = cb.id
          @is_edited = true
        end
      end
    end

    def create
      @can_bo_cong_tac = CanBoCongTac.new params[:can_bo_cong_tac]
      
      cb = CanBoThongTin.find_by_ma_cb(params[:can_bo_cong_tac][:can_bo_thong_tin_id])
      if cb
        @can_bo_cong_tac.can_bo_thong_tin_id = cb.id

        if @can_bo_cong_tac.save
          flash[:notice] = Param.get_param_value("adding_success")
          redirect_to casein_can_bo_cong_tacs_path
        else
          flash.now[:warning] = Param.get_param_value("adding_false")
          render :action => :new
        end
      else
        flash.now[:warning] = Param.get_param_value("cb_not_found") + params[:can_bo_cong_tac][:can_bo_thong_tin_id]
        render :action => :new
      end
    end
  
    def update
      @casein_page_title = Param.get_param_value "can_bo_cong_tac_update_page_title"
      
      @can_bo_cong_tac = CanBoCongTac.find params[:id]
      
      cb = CanBoThongTin.find_by_ma_cb(params[:can_bo_cong_tac][:can_bo_thong_tin_id])
      if cb
        params[:can_bo_cong_tac][:can_bo_thong_tin_id] = cb.id
        if @can_bo_cong_tac.update_attributes params[:can_bo_cong_tac]
          flash[:notice] = Param.get_param_value("updating_success")
          redirect_to casein_can_bo_cong_tacs_path
        else
          flash.now[:warning] = Param.get_param_value("updating_false")
          render :action => :edit
        end
      else
        flash.now[:warning] = Param.get_param_value("cb_not_found") + params[:can_bo_cong_tac][:can_bo_thong_tin_id]
        render :action => :edit
      end

    end
 
    def destroy
      @can_bo_cong_tac = CanBoCongTac.find params[:id]

      @can_bo_cong_tac.destroy
      flash[:notice] = Param.get_param_value("deleting_success")
      redirect_to casein_can_bo_cong_tacs_path
    end

    def import_from_excel
      @casein_page_title = Param.get_param_value "can_bo_cong_tac_import_from_excel_page_title"
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
        p = CanBoCongTac.new
        cbid = CanBoThongTin.find_by_ma_cb(row[0].to_i.to_s)
        if cbid
          p.can_bo_thong_tin_id = cbid.id
          p.nghe_nghiep_truoc_tuyen_dung = row[3].to_s
          p.cong_viec_chinh_duoc_giao = row[4].to_s
          p.so_truong_cong_tac = row[5].to_s
          p.ngay_bat_dau_lam_viec =  row[6].to_date
          p.ghi_chu = row[7].to_s

          iddv = DonVi.find_by_ten_don_vi(row[2].to_s)
          if iddv
            p.don_vi_id = iddv.id
          else
            @wrong += 1
            @errors["#{@counter + 1}"] = "CB.#{row[0].to_i.to_s} - #{row[1].to_s}"
          end
        else
          @wrong += 1
          @errors["#{@counter + 1}"] = "CB.#{row[0].to_i.to_s} - #{row[1].to_s}"
        end


        if p.valid?
            @commit += 1
            p.save
        else
          @errors["#{@counter + 1}"] = "#{row[0].to_s} - #{row[1].to_s}"
          @wrong += 1
        end
      end
      book.io.close
      if @wrong == 0
        flash[:notice] = "#{Param.get_param_value "import_success"} | #{Param.get_param_value "commit"}: #{@commit}/#{@counter} | #{Param.get_param_value "wrong"}: #{@wrong}"
        file.remove!
        redirect_to casein_can_bo_cong_tacs_path
      else
        flash[:notice] = "#{Param.get_param_value "import_success"} | #{Param.get_param_value "commit"}: #{@commit}/#{@counter} | #{Param.get_param_value "wrong"}: #{@wrong}"
        file.remove!
        render :action => 'show_result', :errors => @errors
      end

      else #if :excel_file is null
        flash[:warning] = Param.get_param_value ("let_choose_file_now")
        redirect_to import_from_excel_casein_can_bo_cong_tacs_path
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