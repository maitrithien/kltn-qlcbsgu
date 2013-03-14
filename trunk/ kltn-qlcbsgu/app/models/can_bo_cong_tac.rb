class CanBoCongTac < ActiveRecord::Base
  attr_accessible :can_bo_thong_tin_id, :don_vi_id, :nghe_nghiep_truoc_tuyen_dung, :cong_viec_chinh_duoc_giao, :so_truong_cong_tac, :ngay_bat_dau_lam_viec, :ghi_chu
  belongs_to :can_bo_thong_tin
  belongs_to :don_vi
  validates_presence_of :can_bo_thong_tin_id,:don_vi_id, :ngay_bat_dau_lam_viec, :cong_viec_chinh_duoc_giao ,:message => "#{Param.get_param_value("is_not_blank")}"

  def self.search(search_value)
    ngay_bd_lv = Date.parse(search_value) rescue nil
    if search_value
      where("ngay_bat_dau_lam_viec = ? or can_bo_thong_tin_id in (SELECT id FROM can_bo_thong_tins WHERE ma_cb = ? OR ho_ten LIKE ?)", ngay_bd_lv ,search_value, "%#{search_value}%")
    else
      scoped
    end
  end
end