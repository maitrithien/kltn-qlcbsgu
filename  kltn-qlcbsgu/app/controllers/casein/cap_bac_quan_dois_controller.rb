# Scaffolding generated by Casein v.3.1.11

module Casein
  class CapBacQuanDoisController < Casein::CaseinController
  
    ## optional filters for defining usage according to Casein::Users access_levels
    # before_filter :needs_admin, :except => [:action1, :action2]
    # before_filter :needs_admin_or_current_user, :only => [:action1, :action2]
  
    def index
      @casein_page_title = 'Cap bac quan dois'
      @cap_bac_quan_dois_xls = CapBacQuanDoi.all
  		@cap_bac_quan_dois = CapBacQuanDoi.paginate :page => params[:page]
	  	respond_to do |format|
        format.html
        format.xls{
          cap_bac = Spreadsheet::Workbook.new
          list = cap_bac.create_worksheet :name => 'Danh sach Cap Bac Quan Doi'
          list.row(0).concat %w{Ten_Cap_Bac Ghi_chu}
          @cap_bac_quan_dois_xls.each_with_index { |ct, i|
            list.row(i+1).push(ct.ten_cap_bac, ct.ghi_chu)
          }

          header_format = Spreadsheet::Format.new :color => :green, :weight => :bold
          list.row(0).default_format = header_format
          #output to blob object
          blob = StringIO.new("")
          cap_bac.write blob
          #respond with blob object as a file
          send_data blob.string, :type => :xls, :filename => "Danh_Sach_Cap_Bac_quan_doi.xls"
        }
      end
    end
  
    def show
      @casein_page_title = 'View cap bac quan doi'
      @cap_bac_quan_doi = CapBacQuanDoi.find params[:id]
    end
 
    def new
      @casein_page_title = 'Add a new cap bac quan doi'
    	@cap_bac_quan_doi = CapBacQuanDoi.new
    end

    def create
      @cap_bac_quan_doi = CapBacQuanDoi.new params[:cap_bac_quan_doi]
    
      if @cap_bac_quan_doi.save
        flash[:notice] = 'Cap bac quan doi created'
        redirect_to casein_cap_bac_quan_dois_path
      else
        flash.now[:warning] = 'There were problems when trying to create a new cap bac quan doi'
        render :action => :new
      end
    end
  
    def update
      @casein_page_title = 'Update cap bac quan doi'
      
      @cap_bac_quan_doi = CapBacQuanDoi.find params[:id]
    
      if @cap_bac_quan_doi.update_attributes params[:cap_bac_quan_doi]
        flash[:notice] = 'Cap bac quan doi has been updated'
        redirect_to casein_cap_bac_quan_dois_path
      else
        flash.now[:warning] = 'There were problems when trying to update this cap bac quan doi'
        render :action => :show
      end
    end
 
    def destroy
      @cap_bac_quan_doi = CapBacQuanDoi.find params[:id]

      @cap_bac_quan_doi.destroy
      flash[:notice] = 'Cap bac quan doi has been deleted'
      redirect_to casein_cap_bac_quan_dois_path
    end
    def import_from_excel
      @casein_page_title = Param.get_param_value("cap_bac_quan_doi_import_from_excel_page_title")
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
        p = CapBacQuanDoi.new
        p.ten_cap_bac = row[0].to_s
        p.ghi_chu =  row[1].to_s
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
        redirect_to casein_cap_bac_quan_dois_path
      else
        flash[:notice] = "#{Param.get_param_value "import_success"} | #{Param.get_param_value "commit"}: #{@commit}/#{@counter} | #{Param.get_param_value "wrong"}: #{@wrong}"
        file.remove!
        render :action => 'show_result', :errors => @errors
      end

    end

    def show_result
      @casein_page_title = Param.get_param_value("cap_bac_quan_doi_show_result_page_title")
      @errors = Hash.new
      @errors = params[:errors]
      respond_to do |format|
        format.html
        format.json {head :no_content}
      end
    end
  end
end