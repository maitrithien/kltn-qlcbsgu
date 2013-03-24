class HangThuongBinh < ActiveRecord::Base
  attr_accessible :ti_le_thuong_tat, :ghi_chu
  has_many :can_bo_li_lich_cts
end