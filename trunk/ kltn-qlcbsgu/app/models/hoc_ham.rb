class HocHam < ActiveRecord::Base
  attr_accessible :ghi_chu, :ten_hoc_ham
  #not allow null
  validates_presence_of :ten_hoc_ham, :message => Param.get_param_value("is_not_blank")

  #check unique for attribute
  validates_uniqueness_of :ten_hoc_ham, :message => Param.get_param_value("has_alread_been_taken")
  has_many :can_bo_trinh_dos
end