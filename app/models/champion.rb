class Champion < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection
  attr_accessor :level, :recalculated, :item_1, :item_2, :item_3, :item_4, :item_5, :item_6

  has_and_belongs_to_many :users
  
  default_scope order('name ASC')
  #mount_uploader :image, ImageUploader

  def self.parse(html, image)
    td = html.children()
    champion_stats = { name: td.children().children()[1].get_attribute('title'),
                       image: image,
                       health_base: td[1].text.to_f,
                       health_per_lvl: td[2].text.to_f,
                       health_regen_base: td[3].text.to_f,
                       health_regen_per_lvl: td[4].text.to_f,
                       mana_base: td[5].text.to_f,
                       mana_per_lvl: td[6].text.to_f,
                       mana_regen_base: td[7].text.to_f,
                       mana_regen_per_lvl: td[8].text.to_f,
                       attack_base: td[9].text.to_f,
                       attack_per_lvl: td[10].text.to_f,
                       attack_speed_base: td[11].text.to_f,
                       attack_speed_per_lvl: td[12].text.to_f,
                       armor_base: td[13].text.to_f,
                       armor_per_lvl: td[14].text.to_f,
                       magic_resist_base: td[15].text.to_f,
                       magic_resist_per_level: td[16].text.to_f,
                       movement_speed: td[17].text.to_f,
                       range: td[18].text.to_f
                     }

  end

  def recalculate_stats(data)
    lvl = data[:level].to_i - 1

    self.health_base = self.health_base + self.health_per_lvl * lvl
    self.health_regen_base = self.health_regen_base + self.health_regen_per_lvl * lvl
    self.mana_base = self.mana_base + self.mana_per_lvl * lvl
    self.mana_regen_base = self.mana_regen_base + self.mana_regen_per_lvl * lvl
    self.attack_base = self.attack_base + self.attack_per_lvl * lvl

    self.attack_speed_base = self.attack_speed_base + (lvl * self.attack_speed_base * self.attack_speed_per_lvl/100) 

    self.armor_base = self.armor_base + self.armor_per_lvl * lvl
    self.magic_resist_base = self.magic_resist_base + self.magic_resist_per_level * lvl
    self.recalculated = true
  end
end
