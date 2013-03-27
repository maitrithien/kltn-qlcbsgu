class BacLuong < ActiveRecord::Base
  attr_accessible :ngach_id, :bac, :he_so_luong,:ghi_chu, :vuot_khung

  belongs_to :ngach
  has_many :lich_su_bac_luongs
  has_many :can_bo_thong_tins

  validates_presence_of :ngach_id, :bac,:he_so_luong, :message => "#{Param.get_param_value("is_not_blank")}"

  def self.check_exists(ngach, bac)
      bac_luong = BacLuong.find_by_sql("select 1 from bac_luongs where ngach_id = #{ngach.to_i} and bac = #{ bac.to_i}")
    if bac_luong.count == 0
       return false
    else
      return true
    end
  end

  def self.check_bac_exists(bac_id)
    bac_luong = BacLuong.find_by_sql("select 1 from bac_luongs where id = #{ bac_id.to_i}")
    if bac_luong.count == 0
      return false
    else
      return true
    end
  end

end