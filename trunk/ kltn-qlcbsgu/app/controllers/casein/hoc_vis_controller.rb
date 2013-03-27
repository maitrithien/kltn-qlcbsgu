# Scaffolding generated by Casein v.3.1.11

module Casein
  class HocVisController < Casein::CaseinController
  
    ## optional filters for defining usage according to Casein::Users access_levels
    # before_filter :needs_admin, :except => [:action1, :action2]
    # before_filter :needs_admin_or_current_user, :only => [:action1, :action2]
  
    def index
      @casein_page_title = Param.get_param_value("hoc_vi_index_page_title")
  		@hoc_vis = HocVi.paginate :page => params[:page]
      respond_to do |format|
        format.html
        format.xls{
          hoc_vi = Spreadsheet::Workbook.new
          list = hoc_vi.create_worksheet :name => 'Danh sach hoc vi'
          list.row(0).concat %w{Ten_hoc_vi Ghi_chu}
          @hoc_vis.each_with_index { |h, i| list.row(i+1).push h.ten_hoc_vi, h.ghi_chu}
          header_format = Spreadsheet::Format.new :color => :green, :weight => :bold
          list.row(0).default_format = header_format
          #output to blob object
          blob = StringIO.new("")
          hoc_vi.write blob
          #respond with blob object as a file
          send_data blob.string, :type => :xls, :filename => "Danh_Sach_Hoc_vi.xls"
        }
      end
    end
  
    def show
      @casein_page_title = Param.get_param_value("hoc_vi_show_page_title")
      @hoc_vi = HocVi.find params[:id]
    end
 
    def new
      @casein_page_title = Param.get_param_value("hoc_vi_new_page_title")
    	@hoc_vi = HocVi.new
    end

    def create
      @hoc_vi = HocVi.new params[:hoc_vi]
    
      if @hoc_vi.save
        flash[:notice] = Param.get_param_value("adding_success")
        redirect_to casein_hoc_vis_path
      else
        flash.now[:warning] = Param.get_param_value("adding_false")
        render :action => :new
      end
    end
  
    def update
      @casein_page_title = Param.get_param_value("hoc_vi_update_page_title")
      
      @hoc_vi = HocVi.find params[:id]
    
      if @hoc_vi.update_attributes params[:hoc_vi]
        flash[:notice] = Param.get_param_value("updating_success")
        redirect_to casein_hoc_vis_path
      else
        flash.now[:warning] = Param.get_param_value("updating_false")
        render :action => :show
      end
    end
 
    def destroy
      @hoc_vi = HocVi.find params[:id]

      @hoc_vi.destroy
      flash[:notice] = Param.get_param_value("deleting_false")
      redirect_to casein_hoc_vis_path
    end

    def import_from_excel
      @casein_page_title = Param.get_param_value("hoc_vi_import_from_excel_page_title")
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
          p = HocVi.new
          p.ten_hoc_vi = row[0].to_s
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
          redirect_to casein_hoc_vis_path
        else
          flash[:notice] = "#{Param.get_param_value "import_success"} | #{Param.get_param_value "commit"}: #{@commit}/#{@counter} | #{Param.get_param_value "wrong"}: #{@wrong}"
          file.remove!
          render :action => 'show_result', :errors => @errors
        end

      else #if :excel_file is null
        flash[:warning] = Param.get_param_value ("let_choose_file_now")
        redirect_to import_from_excel_casein_hoc_vis_path
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