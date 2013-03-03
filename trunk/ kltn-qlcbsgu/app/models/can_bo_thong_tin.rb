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

  def self.search_advance(ho_ten,ten_goi_khac,ton_giao,dan_toc,gioi_tinh,so_cmnd, noi_dang_ky_ho_khau_thuong_tru,que_quan,noi_o_hien_nay,so_bhxh,noi_sinh)
    if ho_ten.length > 0 || ten_goi_khac.length > 0 ||ton_giao.length > 0 ||dan_toc.length > 0 ||gioi_tinh != nil ||so_cmnd.length > 0 || noi_dang_ky_ho_khau_thuong_tru.length > 0 ||que_quan.length > 0 ||noi_o_hien_nay.length > 0 ||so_bhxh.length > 0 ||noi_sinh.length > 0
      if gioi_tinh!=nil
        where('ho_ten LIKE ? AND ten_goi_khac LIKE ? AND ton_giao LIKE ? AND dan_toc LIKE ? AND gioi_tinh = ? AND so_cmnd LIKE ? AND noi_dang_ky_ho_khau_thuong_tru LIKE ? AND que_quan LIKE ? AND noi_o_hien_nay LIKE ? AND so_bhxh LIKE ? AND noi_sinh LIKE ?',"%#{ho_ten}%","%#{ten_goi_khac}%","%#{ton_giao}%","%#{dan_toc}%",gioi_tinh,"%#{so_cmnd}%","%#{noi_dang_ky_ho_khau_thuong_tru}%","%#{que_quan}%","%#{noi_o_hien_nay}%","%#{so_bhxh}%","%#{noi_sinh}%")
      else
        where('ho_ten LIKE ? AND ten_goi_khac LIKE ? AND ton_giao LIKE ? AND dan_toc LIKE ? AND so_cmnd LIKE ? AND noi_dang_ky_ho_khau_thuong_tru LIKE ? AND que_quan LIKE ? AND noi_o_hien_nay LIKE ? AND so_bhxh LIKE ? AND noi_sinh LIKE ?',"%#{ho_ten}%","%#{ten_goi_khac}%","%#{ton_giao}%","%#{dan_toc}%","%#{so_cmnd}%","%#{noi_dang_ky_ho_khau_thuong_tru}%","%#{que_quan}%","%#{noi_o_hien_nay}%","%#{so_bhxh}%","%#{noi_sinh}%")
      end
    else
      where('ho_ten ="ten_goi_khac_ho_ten" ')
    end

  end

end