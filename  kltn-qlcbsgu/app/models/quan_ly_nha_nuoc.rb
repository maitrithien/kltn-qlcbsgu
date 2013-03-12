class QuanLyNhaNuoc < ActiveRecord::Base
  attr_accessible :trinh_do, :ghi_chu

  validates_presence_of :trinh_do, :message => Param.get_param_value("is_not_blank")

  validates_uniqueness_of :trinh_do, :message => Param.get_param_value("has_already_been_taken")

  has_many :can_bo_trinh_dos
end