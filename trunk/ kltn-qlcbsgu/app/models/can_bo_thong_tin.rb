class CanBoThongTin < ActiveRecord::Base
  attr_accessible :ma_cb, :hinh_anh, :ho_ten, :ten_goi_khac, :search_by_gioi_tinh, :gioi_tinh, :ngay_sinh, :noi_sinh, :que_quan, :dan_toc, :ton_giao, :so_cmnd, :ngay_cap_cmnd, :so_BHXH, :noi_dang_ky_ho_khau_thuong_tru, :noi_o_hien_nay, :tep_tin_dinh_kem, :is_deleted
  attr_accessor :search_by_gioi_tinh

  #check unique of attributes
  validates_uniqueness_of :ma_cb, :so_cmnd, :message =>"#{Param.get_param_value("has_already_been_taken")}"

  #not allow null attributes
  validates_presence_of :ma_cb, :ho_ten, :ngay_sinh, :noi_sinh, :que_quan, :dan_toc, :ton_giao, :so_cmnd, :noi_dang_ky_ho_khau_thuong_tru,:noi_o_hien_nay, :message => "#{Param.get_param_value("is_not_blank")}"

  mount_uploader :hinh_anh, ImageUploader
  mount_uploader :tep_tin_dinh_kem, FileUploader

  #relationship
  has_many :can_bo_li_lich_cts
  has_many :than_nhans

  def self.search(search_value)
	  if search_value
		where('ma_cb = ? OR ho_ten LIKE ? OR ngay_sinh = ? OR so_cmnd = ?',search_value,"%#{search_value}%", search_value, search_value)
	  else
		scoped
	  end
  end

  def self.search_advance(options={})
    sql_exc = "1"
    options.each do |key, value|
      if key == :gioi_tinh || key == :is_deleted
        sql_exc << " AND #{key} = #{value}"
      else
        sql_exc << " AND #{key} LIKE '%#{value}%'"
      end
    end
    where(sql_exc)
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

end