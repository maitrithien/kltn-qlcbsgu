class LichSuTrinhDo < ActiveRecord::Base
  attr_accessible :can_bo_thong_tin_id, :trinh_do_chuyen_mon_id, :chuyen_nganh_id, :thoi_gian_dat_duoc, :ghi_chu, :can_bo_thong_tin_name

  attr_accessor :can_bo_thong_tin_name
  belongs_to :trinh_do_chuyen_mon
  belongs_to :chuyen_nganh
  belongs_to :can_bo_thong_tin

end


