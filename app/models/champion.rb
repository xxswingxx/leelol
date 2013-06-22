class Champion < ActiveRecord::Base
  attr_accessible :image, :lane, :name
  has_and_belongs_to_many :users

  default_scope order('name ASC')
end
