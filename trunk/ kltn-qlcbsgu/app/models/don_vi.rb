class DonVi < ActiveRecord::Base
  attr_accessible :ten_don_vi, :dia_chi, :so_dien_thoai, :ghi_chu
  has_many :can_bo_cong_tacs
  has_many :qua_trinh_cong_tacs
end