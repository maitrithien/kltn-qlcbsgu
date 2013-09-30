class CanBoThongTin < ActiveRecord::Base
  attr_accessible :ma_cb, 
  :hinh_anh, 
  :bac_luong_id, 
  :ho_ten, 
  :ten_goi_khac, 
  :search_by_gioi_tinh, 
  :gioi_tinh, 
  :ngay_sinh, 
  :noi_sinh, 
  :que_quan, 
  :dan_toc, 
  :ton_giao, 
  :so_cmnd, 
  :ngay_cap_cmnd, 
  :so_BHXH, 
  :noi_dang_ky_ho_khau_thuong_tru, 
  :noi_o_hien_nay, :tep_tin_dinh_kem, 
  :is_deleted, 
  :don_vi_id, 
  :ngach_id, 
  :trinh_do_chuyen_mon_id, 
  :so_quyet_dinh,
  :loai_lao_dong_id,
  :chuc_vu_id,
  :quyet_dinh_id,
  :chuc_vu_code,
  :bac
  attr_accessor :search_by_gioi_tinh, 
  :ngach_id, 
  :trinh_do_chuyen_mon_id, 
  :chuc_vu_code,
  :so_quyet_dinh, 
  :bac

  #check unique of attributes
  validates_uniqueness_of :ma_cb, :so_cmnd, :message =>"#{Param.get_param_value("has_already_been_taken")}"

  #not allow null attributes
  validates_presence_of :ma_cb, 
  :ho_ten, 
  :ngay_sinh, 
  :noi_sinh, 
  :ngach_id,
  :bac,
  :so_cmnd, 
  :don_vi_id,
  :so_quyet_dinh, :message => "#{Param.get_param_value("is_not_blank")}"


  before_save :create_when_empty

  mount_uploader :hinh_anh, ImageUploader
  mount_uploader :tep_tin_dinh_kem, FileUploader

  #relationship
  has_one :can_bo_li_lich_ct
  has_many :than_nhans
  has_one :can_bo_trinh_do
  has_many :lich_su_bac_luongs
  has_one :can_bo_cong_tac
  has_many :qua_trinh_cong_tacs
  belongs_to :bac_luong
  belongs_to :don_vi
  belongs_to :quyet_dinh
  belongs_to :loai_lao_dong
  belongs_to :chuc_vu

  def create_when_empty
    if @ten_goi_khac == ""
     @ten_goi_khac = @ho_ten
    end
  end

  def update_bac_luong_id ngach_id, bac
      bac_luong = BacLuong.where(:ngach_id => ngach_id, :bac => bac).first
      if bac_luong
        self.bac_luong_id = bac_luong.id
      end
  end

  def update_quyet_dinh_id so_quyet_dinh
    quyet_dinh = QuyetDinh.find_by_so_qd(so_quyet_dinh)
    if quyet_dinh
      self.quyet_dinh_id = quyet_dinh.id
    end
  end


  def age
    birthday = self.ngay_sinh
    (Time.now.to_s(:number).to_i - birthday.to_time.to_s(:number).to_i)/10e9.to_i + 1
  end

  def self.search(search_value, don_vi_id)
    ngay_sinh = Date.parse(search_value) rescue nil
	  if search_value
      if don_vi_id != 0
        don_vi = don_vi_id.to_i
        where('ma_cb = ? OR ho_ten LIKE ? OR ngay_sinh = ? OR so_cmnd = ? AND don_vi_id = ?',search_value,"%#{search_value}%", ngay_sinh, search_value, don_vi_id)
      end
		where('ma_cb = ? OR ho_ten LIKE ? OR ngay_sinh = ? OR so_cmnd = ?',search_value,"%#{search_value}%", ngay_sinh, search_value)
	  else
		scoped
	  end
  end

  def self.search_advance(options = {})
    sql_exc = "1"
    options.each do |key, value|
      if key ==:ngach_id
        sql_exc << "  AND bac_luong_id in (select id from bac_luongs where  #{key} = #{value} )"
      end
      if key == :chuc_vu_code
        sql_exc << " AND id in (select can_bo_thong_tin_id from qua_trinh_cong_tacs where chuc_vu_id = #{value} )"
      end 
      if key == :trinh_do_chuyen_mon_id
        sql_exc << " AND id in (select can_bo_thong_tin_id from can_bo_trinh_dos where trinh_do_chuyen_mon_id = #{value} )"
      end
      if key == :ngach_id
        sql_exc << " AND bac_luong_id in (select id from bac_luongs where ngach_id = #{value} )"
      end
      if key == :don_vi_id
        sql_exc << " AND don_vi_id = #{value}"
      end
      if key == :ngay_sinh
        ngay_sinh = Date.parse(search_value) rescue nil
        sql_exc << " AND #{key} = #{value}"
      end
      if key == :gioi_tinh || key == :is_deleted
        sql_exc << " AND #{key} = #{value}"
      end
      unless [:ngach_id, :chuc_vu_code, :trinh_do_chuyen_mon_id, :ngay_sinh, :gioi_tinh, :is_deleted].include?(key)
        sql_exc << " AND #{key} LIKE '%#{value}%'"
      end
    end
    where(sql_exc)
  end

  def self.tim_ten_cho_quyet_dinh(search_value)
   
    where('id in
            (
              select id
              from can_bo_thong_tins 
              where quyet_dinh_id = ?
              union
              select can_bo_thong_tin_id
              from qua_trinh_cong_tacs 
              where quyet_dinh_id = ?
              union
              select can_bo_thong_tin_id
              from lich_su_bac_luongs 
              where quyet_dinh_id = ?
            )',search_value,search_value,search_value
    )  
   
    
  end


  def self.select_can_bo_thong_tin
    hash = []
    CanBoThongTins.each do |o|
       hash = hash.merge(o.id => "#{o.ma_cb} - #{o.ho_ten}")
    end
    return hash
  end

  def self.can_bo_chua_co_li_lich_ct
    where('id not in (select can_bo_thong_tin_id from can_bo_li_lich_cts)')
  end

  def self.statistic(options = {})
    sql_exc = "1"

    options.each do |key, value|

    if key == :gioi_tinh
      if !value.blank?
        if value == "true"
          sql_exc << " AND gioi_tinh = 1"
        else
          sql_exc << " AND gioi_tinh = 0"
        end
      end
    end
    if key == :don_vi_id
      if value.any?
        append = ""
        i = 0
        value.map do |element|
          i += 1
          if i >= 2
            append << " OR "
          end
          append << " don_vi_id = #{element}"
        end
        if !append.blank?
          sql_exc << " AND id in (select id from can_bo_thong_tins where " << append << " )"
        end
      end
    end
    if key == :hoc_vi_id
      if value.any?
        append = ""
        i = 0
        value.map do |element|
          i += 1
          if i >= 2
            append << " OR "
          end
          append << " hoc_vi_id = #{element}"
        end
        if !append.blank?
          sql_exc << " AND id in (select can_bo_thong_tin_id from can_bo_trinh_dos where " << append << " )"
        end
      end
    end
    if key == :hoc_ham_id
      if value.any?
        append = ""
        i = 0
        value.map do |element|
          i += 1
          if i >= 2
            append << " OR "
          end
          append << " hoc_ham_id = #{element}"
        end
        if !append.blank?
          sql_exc << " AND id in (select can_bo_thong_tin_id from can_bo_trinh_dos where " << append << " )"
        end
      end
    end
    if key == :ngach_id
      if value.any?
        append = ""
        i = 0
        value.map do |element|
          i += 1
          if i >= 2
            append << " OR "
          end
          append << " ngach_id = #{element}"
        end
        if !append.blank?
          sql_exc << " AND bac_luong_id in (select id from bac_luongs where " << append  << " )"
        end
      end
    end
    if key == :dan_toc
      if !value.blank?
       if value == "true"
          sql_exc << " AND dan_toc like 'kinh'"
       else
          sql_exc << " AND dan_toc not like 'kinh'"
       end
     end
    end
    if key == :nam_sinh_tu
      if !value.blank?
        sql_exc << " AND year(ngay_sinh) >= " << value 
      end
    end
    if key == :nam_sinh_den
      if !value.blank?
        sql_exc << " AND year(ngay_sinh) <= " << value 
      end
    end
    if key == :dang_vien
      if !value.blank?
        if value == "true"
          sql_exc << " AND id in (select can_bo_thong_tin_id from can_bo_li_lich_cts where ngay_vao_dang is not null)"
        else
          sql_exc << " AND id in (select can_bo_thong_tin_id from can_bo_li_lich_cts where ngay_vao_dang is null)"
        end
      end
    end
    if key == :nam_cong_tac
      if !value.blank?
        sql_exc << " AND id in (select can_bo_thong_tin_id from can_bo_cong_tacs where (YEAR(CURDATE())- YEAR(ngay_bat_dau_lam_viec) + 1) >= " << value << " )"
      end
    end
    if key == :gia_dinh_chinh_sach
      if !value.blank?
        if value == "true"
          sql_exc << " AND id in (select can_bo_thong_tin_id from can_bo_li_lich_cts where con_gia_dinh_chinh_sach is not null)"
        else
          sql_exc << " AND id in (select can_bo_thong_tin_id from can_bo_li_lich_cts where con_gia_dinh_chinh_sach is null)"
        end
      end
    end

    end #end options
    if sql_exc != "1"
      where(sql_exc + " AND is_deleted = false") #execute sql query
    else
      return []
    end
  end

  def self.random_record gender = false, f_name = [], m_name = [], l_name = [], place = [], work = [], num_record = 0
    range = Array(10000..19999)
    card = Array(225500000..225600000)
    arr = []
    hv_arr = []
    hh_arr = []
    HangThuongBinh.all.each{|e| arr.push e.id}
    arr.push nil
    HocVi.all.each{|e| hv_arr.push e.id}
    hv_arr.push nil
    HocHam.all.each{|e| hh_arr.push e.id}
    hh_arr.push nil

    num_record.times do |r|
      f = f_name.sample
      m = m_name.sample
      l = l_name.sample
      r_id = range.sample
      p = place.sample
      
      begin
        str = "#{f} #{m} #{l}"
        r = CanBoThongTin.new
        r.ma_cb = r_id
        r.ho_ten = str
        r.ten_goi_khac = str
        r.gioi_tinh = gender
        r.hinh_anh = ""
        r.ngay_sinh = Date.parse "1/1/1991" rescue nil
        r.noi_sinh = p
        r.que_quan = p
        r.dan_toc = "Kinh"
        r.ton_giao = "Khong"
        r.so_cmnd = card.sample
        r.ngay_cap_cmnd = Date.parse "1/12/2000" rescue nil
        r.so_BHXH = ""
        r.noi_dang_ky_ho_khau_thuong_tru = p
        r.noi_o_hien_nay = p
        r.tep_tin_dinh_kem = ""
        r.is_deleted = false
        r.bac_luong_id = BacLuong.all.sample.id
        r.quyet_dinh_id = QuyetDinh.all.sample.id
        r.don_vi_id = DonVi.all.sample.id
        r.loai_lao_dong_id = LoaiLaoDong.all.sample.id
        r.chuc_vu_id = ChucVu.all.sample.id
        #puts "#{r.ho_ten}\n"

        if r.save!
          puts "#{r.ho_ten}\n"
          ct = CanBoCongTac.new
          ct.can_bo_thong_tin_id = r.id
          ct.don_vi_id = r.don_vi_id
          ct.nghe_nghiep_truoc_tuyen_dung = work.sample
          ct.so_truong_cong_tac = ""
          ct.ngay_bat_dau_lam_viec = DateTime.now.to_date
          ct.ghi_chu = ""
          ct.cong_viec_id = CongViec.all.sample.id
          if ct.save!
            puts "CanBoCongTac's created!\n"
          end

          qtct = QuaTrinhCongTac.new
          qtct.can_bo_thong_tin_id = r.id
          qtct.chuc_vu_id = r.chuc_vu_id
          qtct.don_vi_id = r.don_vi_id
          qtct.thoi_gian_bat_dau = DateTime.now.to_date
          qtct.thoi_gian_ket_thuc = nil
          qtct.quyet_dinh_id = r.quyet_dinh_id
          if qtct.save!
            puts "QuaTrinhCongTac's created!\n"
          end

          td = CanBoTrinhDo.new
          td.can_bo_thong_tin_id = r.id
          td.hoc_ham_id = hh_arr.sample
          td.hoc_vi_id = hv_arr.sample
          td.chuyen_nganh_id =ChuyenNganh.all.sample.id
          td.ly_luan_chinh_tri_id = LyLuanChinhTri.all.sample.id
          td.ngoai_ngu_id = NgoaiNgu.all.sample.id
          td.quan_ly_nha_nuoc_id = QuanLyNhaNuoc.all.sample.id 
          td.trinh_do_chuyen_mon_id = TrinhDoChuyenMon.all.sample.id
          td.trinh_do_gd_pho_thong = "12/12"
          td.trinh_do_ngoai_ngu = ""
          td.trinh_do_tin_hoc = [nil, "A", "B", "C"].sample
          if td.save!
            puts "CanBoTrinhDo's created!\n"
          end

          llct = CanBoLiLichCt.new
          llct.can_bo_thong_tin_id = r.id 
          llct.con_gia_dinh_chinh_sach = ""
          llct.danh_hieu_duoc_phong_tang = ""
          if gender
            llct.ngay_nhap_ngu = Date.parse "12/1/2011"
            llct.ngay_xuat_ngu = Date.parse "12/8/2012"
          end
          llct.ngay_vao_dang = DateTime.now.to_date
          llct.cap_bac_quan_doi_id = CapBacQuanDoi.all.sample.id
          llct.hang_thuong_binh_id = arr.sample
          if llct.save!
            puts "CanBoLiLichCt's created!\n"
          end

          lsbl = LichSuBacLuong.new
          lsbl.can_bo_thong_tin_id = r.id
          lsbl.ngay_thay_doi_bac = DateTime.now.to_date
          lsbl.ghi_chu = ""
          lsbl.bac_luong_id = r.bac_luong_id
          r.quyet_dinh_id = QuyetDinh.all.sample.id
          if lsbl.save!
            puts "LichSuBacLuong's created!\n"
          end


        end
      rescue Exception => e
        puts e
        #raise ActiveRecord::Rollback, "Command is terminated!"
      end #end begin
    end #end loop
  end #end func


end #end class