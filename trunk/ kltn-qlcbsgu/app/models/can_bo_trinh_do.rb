class CanBoTrinhDo < ActiveRecord::Base
  attr_accessible :can_bo_thong_tin_id, :hoc_ham_id, :hoc_vi_id, :tieng_anh, :tin_hoc, :trinh_do_chuyen_mon_id, :trinh_do_hoc_van, :trinh_do_ll_ct

  validates_presence_of :can_bo_thong_tin_id, :trinh_do_hoc_van, :message => Param.get_param_value("is_not_blank")
  validates_uniqueness_of :can_bo_thong_tin_id, :message => Param.get_param_value("has_already_been_taken")

  belongs_to :can_bo_thong_tin
  belongs_to :trinh_do_chuyen_mon
  belongs_to :hoc_ham
  belongs_to :hoc_vi
end