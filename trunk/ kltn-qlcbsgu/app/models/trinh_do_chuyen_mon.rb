class TrinhDoChuyenMon < ActiveRecord::Base
  attr_accessible :ten_trinh_do_cm, :ghi_chu

  has_many :can_bo_trinh_dos
end