class CanBoThongTin < ActiveRecord::Base
  attr_accessible :ma_cb, :hinh_anh, :bac_luong_id, :ho_ten, :ten_goi_khac, :search_by_gioi_tinh, :gioi_tinh, :ngay_sinh, :noi_sinh, :que_quan, :dan_toc, :ton_giao, :so_cmnd, :ngay_cap_cmnd, :so_BHXH, :noi_dang_ky_ho_khau_thuong_tru, :noi_o_hien_nay, :tep_tin_dinh_kem, :is_deleted,:don_vi_id, :ngach_id, :trinh_do_chuyen_mon_id, :chuc_vu_id
  attr_accessor :search_by_gioi_tinh,:don_vi_id, :ngach_id, :trinh_do_chuyen_mon_id, :chuc_vu_id

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

  def self.search(search_value)
    ngay_sinh = Date.parse(search_value) rescue nil
	  if search_value
		where('ma_cb = ? OR ho_ten LIKE ? OR ngay_sinh = ? OR so_cmnd = ?',search_value,"%#{search_value}%", ngay_sinh, search_value)
	  else
		scoped
	  end
  end

  def self.search_advance(options={})
    sql_exc = "1"
    options.each do |key, value|
      if key == :don_vi_id ||key == :chuc_vu_id
        sql_exc << " AND id in (select can_bo_thong_tin_id from qua_trinh_cong_tacs where #{key} = #{value} )"
      else
          if key == :trinh_do_chuyen_mon_id
            sql_exc << " AND id in (select can_bo_thong_tin_id from can_bo_trinh_dos where trinh_do_chuyen_mon_id = #{value} )"
          else
            if key == :ngach_id
              sql_exc << " AND bac_luong_id in (select id from bac_luongs where ngach_id = #{value} )"
            else
              if key == :ngay_sinh
                ngay_sinh = Date.parse(search_value) rescue nil
                sql_exc << " AND #{key} = #{value}"
              else
                if key == :gioi_tinh || key == :is_deleted
                  sql_exc << " AND #{key} = #{value}"
                else
                  sql_exc << " AND #{key} LIKE '%#{value}%'"
                end
              end
            end
          end
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