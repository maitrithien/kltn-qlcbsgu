class QuyetDinh < ActiveRecord::Base
  attr_accessible :so_qd, :loai_quyet_dinh_id, :ngay_ra_qd, :noi_dung_tom_tat, :tep_tin_dinh_kem

  mount_uploader :tep_tin_dinh_kem, FileUploader

  validates_presence_of :so_qd, :loai_quyet_dinh_id, :ngay_ra_qd, :noi_dung_tom_tat, :message => Param.get_param_value("is_not_blank")

  validates_uniqueness_of :so_qd, :message => Param.get_param_value("has_already_been_taken")

  belongs_to :loai_quyet_dinh

  has_many :lich_su_bac_luongs
  has_many :can_bo_thong_tins
  has_many :qua_trinh_cong_tacs

  def self.search(search_value)
    date = Date.parse(search_value) rescue nil
    if search_value
      can_bo = CanBoThongTin.find_by_ma_cb(search_value)
      if can_bo
        where('so_qd LIKE ? OR ngay_ra_qd = ? OR id in (select quyet_dinh_id from can_bo_thong_tins where id = ? union select quyet_dinh_id from qua_trinh_cong_tacs where can_bo_thong_tin_id =? union select quyet_dinh_id from lich_su_bac_luongs where can_bo_thong_tin_id =?)', "%#{search_value}%", date,can_bo.id,can_bo.id,can_bo.id)  
      end
      
    else
      scoped
    end
  end
end