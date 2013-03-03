class CanBoThongTin < ActiveRecord::Base
  attr_accessible :ma_cb, :hinh_anh, :ho_ten, :ten_goi_khac, :gioi_tinh, :ngay_sinh, :noi_sinh, :que_quan, :dan_toc, :ton_giao, :so_cmnd, :ngay_cap_cmnd, :so_BHXH, :noi_dang_ky_ho_khau_thuong_tru, :noi_o_hien_nay, :tep_tin_dinh_kem, :is_deleted
  validates_uniqueness_of :ma_cb, :so_cmnd
  validates_presence_of :ma_cb, :ho_ten, :ngay_sinh, :noi_sinh, :que_quan, :dan_toc, :ton_giao, :so_cmnd, :noi_dang_ky_ho_khau_thuong_tru,:noi_o_hien_nay
  mount_uploader :hinh_anh, ImageUploader
  mount_uploader :tep_tin_dinh_kem, FileUploader

  def self.search(search_value)
	  if search_value
		where('ma_cb = ? OR ho_ten LIKE ? OR ngay_sinh = ? OR so_cmnd = ?',search_value,"%#{search_value}%", search_value, search_value)
	  else
		scoped
	  end
  end

  def self.search_advance(ma_cb,ho_ten,dan_toc,noi_o_hien_nay,so_cmnd,noi_dang_ky_ho_khau_thuong_tru)

    if ma_cb.length>0
      where('ma_cb = ? AND ho_ten LIKE ? AND dan_toc LIKE ? AND noi_o_hien_nay LIKE ? AND so_cmnd LIKE ? AND noi_dang_ky_ho_khau_thuong_tru LIKE ?',ma_cb,"%#{ho_ten}%","%#{dan_toc}%","%#{noi_o_hien_nay}%","%#{so_cmnd}%","%#{noi_dang_ky_ho_khau_thuong_tru}%")
    else
      where('ho_ten LIKE ? AND dan_toc LIKE ? AND noi_o_hien_nay LIKE ? AND so_cmnd LIKE ? AND noi_dang_ky_ho_khau_thuong_tru LIKE ?',"%#{ho_ten}%","%#{dan_toc}%","%#{noi_o_hien_nay}%","%#{so_cmnd}%","%#{noi_dang_ky_ho_khau_thuong_tru}%")
    end
  end

end