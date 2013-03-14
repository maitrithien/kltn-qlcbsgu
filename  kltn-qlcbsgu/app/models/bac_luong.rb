class BacLuong < ActiveRecord::Base
  attr_accessible :ngach_id, :bac, :he_so_luong,:ghi_chu
  belongs_to :ngach
  has_many :lich_su_bac_luongs
  validates_presence_of :bac,:he_so_luong, :message => "#{Param.get_param_value("is_not_blank")}"
end