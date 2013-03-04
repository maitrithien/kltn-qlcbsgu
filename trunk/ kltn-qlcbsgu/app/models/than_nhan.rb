class ThanNhan < ActiveRecord::Base
  attr_accessible :can_bo_thong_tin_id, :ho_ten, :nam_sinh, :nghe_nghiep, :quan_he_voi_cb

  #not allow null attributes and custom default message
  validates_presence_of :can_bo_thong_tin_id, :ho_ten, :nam_sinh, :nghe_nghiep, :quan_he_voi_cb, :message => "#{Param.get_param_value("is_not_blank")}"

  #check unique for attributes
  validates_uniqueness_of :quan_he_voi_cb

  #relationship
  belongs_to :can_bo_thong_tin

  def self.select_quan_he
    Param.get_param_value("select_quan_he_cb").split(',').to_a
  end
end