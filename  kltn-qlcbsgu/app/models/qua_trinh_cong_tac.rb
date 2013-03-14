class QuaTrinhCongTac < ActiveRecord::Base
    attr_accessible :can_bo_thong_tin_id,:chuc_vu_id,:don_vi_id,:thoi_gian_bat_dau,:thoi_gian_ket_thuc,:ghi_chu
    belongs_to :can_bo_thong_tin
    belongs_to :chuc_vu
    belongs_to :don_vi
    def self.search(search_value)
      if search_value
        where(" can_bo_thong_tin_id in (SELECT id FROM can_bo_thong_tins WHERE ma_cb = ? OR ho_ten LIKE ?)", search_value, "%#{search_value}%")
      else
        scoped
      end
    end
end