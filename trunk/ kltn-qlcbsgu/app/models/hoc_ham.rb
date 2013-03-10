class HocHam < ActiveRecord::Base
  attr_accessible :ghi_chu, :ten_hoc_ham

  has_many :can_bo_trinh_dos
end