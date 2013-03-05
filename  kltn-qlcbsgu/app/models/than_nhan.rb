class ThanNhan < ActiveRecord::Base
  attr_accessible :can_bo_thong_tin_id, :ho_ten, :nam_sinh, :nghe_nghiep, :quan_he_voi_cb

  #not allow null attributes and custom default message
  validates_presence_of :can_bo_thong_tin_id, :ho_ten, :nam_sinh, :nghe_nghiep, :quan_he_voi_cb, :message => "#{Param.get_param_value("is_not_blank")}"



  #relationship
  belongs_to :can_bo_thong_tin

  def self.is_duplicate(options = {})
     where("id = ? AND ho_ten = ? AND quan_he_voi_cb = ?", options[:id], options[:ho_ten], options[:quan_he_voi_cb])
  end

  def self.select_quan_he
    Param.get_param_value("select_quan_he_cb").split(',').to_a
  end

  def self.search(search_value)

    if search_value
      where("ho_ten LIKE ? OR can_bo_thong_tin_id in (SELECT id FROM can_bo_thong_tins WHERE ma_cb = ? OR ho_ten LIKE ?)", "%#{search_value}%", search_value, "%#{search_value}%")
    else
      scoped
    end
  end
end