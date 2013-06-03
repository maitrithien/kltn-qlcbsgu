class DonVi < ActiveRecord::Base
  attr_accessible :ten_don_vi, :dia_chi, :so_dien_thoai, :ghi_chu, :loai_don_vi_id,:email

  validates_presence_of :ten_don_vi, :dia_chi, :message => "#{Param.get_param_value "is_not_blank"}"
  validates_uniqueness_of :ten_don_vi, :message => "#{Param.get_param_value "has_already_been_taken"}"

  has_many :can_bo_cong_tacs
  has_many :qua_trinh_cong_tacs
  belongs_to :loai_don_vi
end