class Champion < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection

  has_and_belongs_to_many :users
  
  default_scope order('name ASC')
  mount_uploader :image, ImageUploader

end
