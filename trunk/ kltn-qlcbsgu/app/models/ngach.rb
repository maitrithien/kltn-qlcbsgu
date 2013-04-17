class Ngach < ActiveRecord::Base
  attr_accessible :ten_ngach, :ghi_chu, :ma_ngach ,:nien_han
  has_many :bac_luongs
  validates_presence_of :ma_ngach, :ten_ngach, :message => "#{Param.get_param_value("is_not_blank")}"
  validates_uniqueness_of :ma_ngach, :ten_ngach, :message =>"#{Param.get_param_value("has_already_been_taken")}"



end