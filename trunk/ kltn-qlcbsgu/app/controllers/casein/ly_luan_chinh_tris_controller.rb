# Scaffolding generated by Casein v.3.1.11

module Casein
  class LyLuanChinhTrisController < Casein::CaseinController
  
    ## optional filters for defining usage according to Casein::Users access_levels
    # before_filter :needs_admin, :except => [:action1, :action2]
    # before_filter :needs_admin_or_current_user, :only => [:action1, :action2]
  
    def index
      @casein_page_title = Param.get_param_value("ly_luan_chinh_tri_index_page_title")
  		@ly_luan_chinh_tris = LyLuanChinhTri.paginate :page => params[:page], :per_page => 10
      @ly_luan_chinh_tris_xls = LyLuanChinhTri.all

      respond_to do |format|
        format.html
        format.xls{
          ly_luan_chinh_tri = Spreadsheet::Workbook.new
          list = ly_luan_chinh_tri.create_worksheet :name => 'Danh sach trinh do ly luan chinh tri'
          list.row(0).concat %w{Trinh_do Ghi_chu}
          @ly_luan_chinh_tris_xls.each_with_index { |h, i| list.row(i+1).push h.trinh_do, h.ghi_chu}
          header_format = Spreadsheet::Format.new :color => :green, :weight => :bold
          list.row(0).default_format = header_format
          #output to blob object
          blob = StringIO.new("")
          ly_luan_chinh_tri.write blob
          #respond with blob object as a file
          send_data blob.string, :type => :xls, :filename => "Danh_sach_trinh_do_ly_luan_chinh_tri.xls"
        }
      end

    end
  
    def show
      @casein_page_title = Param.get_param_value("ly_luan_chinh_tri_show_page_title")
      @ly_luan_chinh_tri = LyLuanChinhTri.find params[:id]
    end
 
    def new
      @casein_page_title = Param.get_param_value("ly_luan_chinh_tri_new_page_title")
    	@ly_luan_chinh_tri = LyLuanChinhTri.new
    end

    def create
      @ly_luan_chinh_tri = LyLuanChinhTri.new params[:ly_luan_chinh_tri]
    
      if @ly_luan_chinh_tri.save
        flash[:notice] = Param.get_param_value("adding_success")
        redirect_to casein_ly_luan_chinh_tris_path
      else
        flash.now[:warning] = Param.get_param_value("adding_false")
        render :action => :new
      end
    end
  
    def update
      @casein_page_title = Param.get_param_value("ly_luan_chinh_tri_update_page_title")
      
      @ly_luan_chinh_tri = LyLuanChinhTri.find params[:id]
    
      if @ly_luan_chinh_tri.update_attributes params[:ly_luan_chinh_tri]
        flash[:notice] = Param.get_param_value("updating_success")
        redirect_to casein_ly_luan_chinh_tris_path
      else
        flash.now[:warning] = Param.get_param_value("updating_false")
        render :action => :show
      end
    end
 
    def destroy
      @ly_luan_chinh_tri = LyLuanChinhTri.find params[:id]

      @ly_luan_chinh_tri.destroy
      flash[:notice] = Param.get_param_value("deleting_success")
      redirect_to casein_ly_luan_chinh_tris_path
    end

    def import_from_excel
      @casein_page_title = Param.get_param_value("ly_luan_chinh_tri_import_from_excel_page_title")
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
          p = LyLuanChinhTri.new
          p.trinh_do = row[0].to_s
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
          redirect_to casein_ly_luan_chinh_tris_path
        else
          flash[:notice] = "#{Param.get_param_value "import_success"} | #{Param.get_param_value "commit"}: #{@commit}/#{@counter} | #{Param.get_param_value "wrong"}: #{@wrong}"
          file.remove!
          render :action => 'show_result', :errors => @errors
        end

      else #if :excel_file is null
        flash[:warning] = Param.get_param_value ("let_choose_file_now")
        redirect_to import_from_excel_casein_ly_luan_chinh_tris_path
      end
    end


    def show_result
      @casein_page_title = Param.get_param_value("hoc_ham_show_result_page_title")
      @errors = Hash.new
      @errors = params[:errors]
      respond_to do |format|
        format.html
        format.json {head :no_content}
      end
    end
  
  end
end