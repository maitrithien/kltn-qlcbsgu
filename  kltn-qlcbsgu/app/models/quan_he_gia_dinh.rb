class QuanHeGiaDinh < ActiveRecord::Base
  attr_accessible :ten_quan_he, :ghi_chu

  validates_uniqueness_of :ten_quan_he, :message => Param.get_param_value("has_already_been_taken")
  validates_presence_of :ten_quan_he, :message => Param.get_param_value("is_not_blank")

  has_many :than_nhans
end