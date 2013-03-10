class QuyetDinh < ActiveRecord::Base
  attr_accessible :so_qd, :loai_quyet_dinh_id, :ngay_ra_qd, :noi_dung_tom_tat, :tep_tin_dinh_kem

  mount_uploader :tep_tin_dinh_kem, FileUploader

  validates_presence_of :so_qd, :loai_quyet_dinh_id, :ngay_ra_qd, :noi_dung_tom_tat, :message => Param.get_param_value("is_not_blank")

  validates_uniqueness_of :so_qd, :message => Param.get_param_value("has_already_been_taken")

  belongs_to :loai_quyet_dinh

  def self.search(search_value)
    date = Date.parse(search_value) rescue nil
    if search_value
      where('so_qd LIKE ? OR ngay_ra_qd = ?', "%#{search_value}%", date)
    else
      scoped
    end
  end
end