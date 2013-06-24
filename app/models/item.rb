class Item < ActiveRecord::Base

  serialize :stats, Hash
  serialize :passive, Array
end
