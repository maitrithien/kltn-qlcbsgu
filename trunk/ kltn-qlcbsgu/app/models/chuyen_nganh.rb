class ChuyenNganh < ActiveRecord::Base
  attr_accessible :ten_chuyen_nganh, :ghi_chu

  validates_presence_of :ten_chuyen_nganh, :message => "#{Param.get_param_value("is_not_blank")}"

  validates_uniqueness_of :ten_chuyen_nganh, :message => "#{Param.get_param_value("has_already_been_taken")}"

  has_many :can_bo_trinh_dos

  def self.search(search_value)

    if search_value
      where("ten_chuyen_nganh LIKE ? OR ghi_chu LIKE ?",  "%#{search_value}%", "%#{search_value}%")
    else
      scoped
    end
  end
end