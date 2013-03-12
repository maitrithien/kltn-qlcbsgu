class NgoaiNgu < ActiveRecord::Base
  attr_accessible :ten_ngoai_ngu, :ghi_chu

  validates_presence_of :ten_ngoai_ngu, :message => Param.get_param_value("is_not_blank")

  validates_uniqueness_of :ten_ngoai_ngu, :message => Param.get_param_value("has_already_been_taken")

  #relationship
  has_many :can_bo_trinh_dos
end