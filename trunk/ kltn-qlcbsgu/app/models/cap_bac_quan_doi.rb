class CapBacQuanDoi < ActiveRecord::Base
  attr_accessible :ten_cap_bac, :ghi_chu
  has_many :can_bo_li_lich_cts
end