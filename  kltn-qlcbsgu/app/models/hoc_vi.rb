class HocVi < ActiveRecord::Base
  attr_accessible :ten_hoc_vi, :ghi_chu

  has_many :can_bo_trinh_dos

  #not allow null
  validates_presence_of :ten_hoc_vi, :message => Param.get_param_value("is_not_blank")

  #check unique for attribute
  validates_uniqueness_of :ten_hoc_vi, :message => Param.get_param_value("has_alread_been_taken")
end