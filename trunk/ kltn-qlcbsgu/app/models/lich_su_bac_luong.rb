class LichSuBacLuong < ActiveRecord::Base
  attr_accessible :can_bo_thong_tin_id, :ngay_thay_doi_bac, :ghi_chu, :bac_luong_id
  #relationship
  belongs_to :bac_luong
  belongs_to :can_bo_thong_tin
  validates_presence_of :can_bo_thong_tin_id, :ngay_thay_doi_bac, :bac_luong_id, :message => "#{Param.get_param_value("is_not_blank")}"

  def self.search(search_value)
    if search_value
      where('can_bo_thong_tin_id in (select id from can_bo_thong_tins where ma_cb=? or ho_ten like ?)',search_value,"%#{search_value}%")
    else
      scoped
    end
  end

  def self.get_last can_bo_thong_tin_id
    p = []
    if can_bo_thong_tin_id
      p = LichSuBacLuong.find_all_by_can_bo_thong_tin_id(can_bo_thong_tin_id, :order => :ngay_thay_doi_bac)
      return p.last
    end
      
  end
end


