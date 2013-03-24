class CanBoLiLichCt < ActiveRecord::Base
  attr_accessible :can_bo_thong_tin_id, :con_gia_dinh_chinh_sach, :danh_hieu_duoc_phong_tang, :ngay_nhap_ngu, :ngay_xuat_ngu, :ngay_vao_dang, :cap_bac_quan_doi_id, :hang_thuong_binh_id ,:ho_ten_return
  attr_accessor :ho_ten_return
  #not allow null attributes
  validates_presence_of :can_bo_thong_tin_id, :message =>"#{Param.get_param_value("is_not_blank")}"
  #check unique for attributes
  validates_uniqueness_of :can_bo_thong_tin_id, :message =>"#{Param.get_param_value("has_already_been_taken")}"

  #relationship
  belongs_to :can_bo_thong_tin
  belongs_to :cap_bac_quan_doi
  belongs_to :hang_thuong_binh
  def self.search(search_value)

    if search_value
      where("can_bo_thong_tin_id in (SELECT id FROM can_bo_thong_tins WHERE ma_cb = ? OR ho_ten LIKE ?)",  search_value, "%#{search_value}%")
    else
      scoped
    end
  end
end