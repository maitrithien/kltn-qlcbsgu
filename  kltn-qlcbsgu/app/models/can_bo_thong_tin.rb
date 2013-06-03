class CanBoThongTin < ActiveRecord::Base
  attr_accessible :ma_cb, :hinh_anh, :bac_luong_id, :ho_ten, :ten_goi_khac, :search_by_gioi_tinh, :gioi_tinh, :ngay_sinh, :noi_sinh, :que_quan, :dan_toc, :ton_giao, :so_cmnd, :ngay_cap_cmnd, :so_BHXH, :noi_dang_ky_ho_khau_thuong_tru, :noi_o_hien_nay, :tep_tin_dinh_kem, :is_deleted, :don_vi_id, :ngach_id, :trinh_do_chuyen_mon_id, :chuc_vu_id,:so_quyet_dinh
  attr_accessor :search_by_gioi_tinh, :ngach_id, :trinh_do_chuyen_mon_id, :chuc_vu_id,:so_quyet_dinh

  #check unique of attributes
  validates_uniqueness_of :ma_cb, :so_cmnd, :message =>"#{Param.get_param_value("has_already_been_taken")}"

  #not allow null attributes
  validates_presence_of :ma_cb, :ho_ten, :ngay_sinh, :noi_sinh, :que_quan, :dan_toc, :ton_giao, :so_cmnd, :noi_dang_ky_ho_khau_thuong_tru,:noi_o_hien_nay, :message => "#{Param.get_param_value("is_not_blank")}"


  mount_uploader :hinh_anh, ImageUploader
  mount_uploader :tep_tin_dinh_kem, FileUploader

  #relationship
  has_many :can_bo_li_lich_cts
  has_many :than_nhans
  has_many :can_bo_trinh_dos
  has_many :lich_su_bac_luongs
  has_many :can_bo_cong_tacs
  has_many :qua_trinh_cong_tacs
  belongs_to :bac_luong
  belongs_to :don_vi
  belongs_to :quyet_dinh

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
      if key == :chuc_vu_id
        sql_exc << " AND id in (select can_bo_thong_tin_id from qua_trinh_cong_tacs where #{key} = #{value} )"
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
      unless [:ngach_id, :chuc_vu_id, :trinh_do_chuyen_mon_id, :ngay_sinh, :gioi_tinh, :is_deleted].include?(key)
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



end