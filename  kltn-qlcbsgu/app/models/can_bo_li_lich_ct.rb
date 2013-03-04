class CanBoLiLichCt < ActiveRecord::Base
  attr_accessible :can_bo_thong_tin_id, :con_gia_dinh_chinh_sach, :danh_hieu_duoc_phong_tang, :ngay_nhap_ngu, :ngay_xuat_ngu, :ngay_vao_dang, :quan_ham_cao_nhat, :thuong_binh_hang
  #not allow null attributes
  validates_presence_of :can_bo_thong_tin_id, :message =>"#{Param.get_param_value("is_not_blank")}"
  #check unique for attributes
  validates_uniqueness_of :can_bo_thong_tin_id, :message =>"#{Param.get_param_value("has_already_been_taken")}"

  #relationship
  belongs_to :can_bo_thong_tin

end