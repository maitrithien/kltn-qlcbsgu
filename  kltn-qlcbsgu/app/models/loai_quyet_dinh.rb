class LoaiQuyetDinh < ActiveRecord::Base
  attr_accessible :ten_loai_qd, :ghi_chu

  validates_presence_of :ten_loai_qd, :message => Param.get_param_value("is_not_blank")

  validates_uniqueness_of :ten_loai_qd, :message => Param.get_param_value("has_already_been_taken")

  has_many :quyet_dinhs
end