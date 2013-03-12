class CanBoTrinhDo < ActiveRecord::Base
  attr_accessible :can_bo_thong_tin_id, :hoc_ham_id, :hoc_vi_id, :chuyen_nganh_id, :ly_luan_chinh_tri_id, :ngoai_ngu_id, :quan_ly_nha_nuoc_id, :trinh_do_chuyen_mon_id, :trinh_do_gd_pho_thong, :trinh_do_ngoai_ngu, :trinh_do_tin_hoc

  validates_presence_of :can_bo_thong_tin_id, :trinh_do_chuyen_mon_id, :trinh_do_gd_pho_thong

  validates_uniqueness_of :can_bo_thong_tin_id

  belongs_to :can_bo_thong_tin
  belongs_to :trinh_do_chuyen_mon
  belongs_to :chuyen_nganh
  belongs_to :ngoai_ngu
  belongs_to :ly_luan_chinh_tri
  belongs_to :quan_ly_nha_nuoc
  belongs_to :hoc_vi
  belongs_to :hoc_ham

  def self.search(search_value)

    if search_value
      where("can_bo_thong_tin_id in (SELECT id FROM can_bo_thong_tins WHERE ma_cb = ? OR ho_ten LIKE ?)",  search_value, "%#{search_value}%")
    else
      scoped
    end
  end

end