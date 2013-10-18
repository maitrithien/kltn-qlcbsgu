class QuaTrinhCongTac < ActiveRecord::Base
    attr_accessible :can_bo_thong_tin_id, :can_bo_thong_tin_name, :chuc_vu_id, :don_vi_id, :thoi_gian_bat_dau,:thoi_gian_ket_thuc,:ghi_chu,:so_quyet_dinh, :quyet_dinh_id
    attr_accessor :can_bo_thong_tin_name,:so_quyet_dinh, :quyet_dinh_id

    belongs_to :can_bo_thong_tin
    belongs_to :chuc_vu
    belongs_to :don_vi
    belongs_to :quyet_dinh
    validates_presence_of :can_bo_thong_tin_id, :don_vi_id, :thoi_gian_bat_dau, :message => "#{Param.get_param_value "is_not_blank"}"



    def self.search(search_value)
      if search_value
        where(" can_bo_thong_tin_id in (SELECT id FROM can_bo_thong_tins WHERE ma_cb = ? OR ho_ten LIKE ?)", search_value, "%#{search_value}%")
      else
        scoped
      end
    end

    def self.get_last can_bo_thong_tin_id
    if can_bo_thong_tin_id
      p = QuaTrinhCongTac.find_all_by_can_bo_thong_tin_id(can_bo_thong_tin_id, :order => :created_at)
      return p.last
    end
  end
end