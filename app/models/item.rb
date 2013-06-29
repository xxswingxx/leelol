class Item < ActiveRecord::Base

  serialize :stats, Hash
  serialize :passive, Array

  default_scope order('name ASC')

  def self.parse(item)
      id = item.get_attribute('href').match(/\d+$/).to_a.first
      item_stats = Nokogiri::HTML(open("http://www.mobafire.com/ajax/tooltip?relation_type=Item&relation_id=#{id}")).text.strip().gsub("\r\n", '').split("\t").reject {|c| c.empty?}

      # item_stats = { 0 => Name, 1 => Total price, 2 => Recipe price, 3 => Stats&descr }

      image = item.at_css('img').get_attribute('src')
      name = item_stats[0].gsub('Classic Only', '').gsub('Dominion Only', '')
      cost = item_stats[1].split(': ').last

      desc = "@ #{item_stats[3].gsub(/UNIQUE\s[\w\W]*/, '')}".scan(/[@,]\s(\d+\s[A-Z][\s*\w*]+)/)
      uniques = [item_stats[3].match(/UNIQUE\s[\w\W]*/).to_a[0].try(:gsub, ':', '-')]

      stats = Hash.new
      
      # Just in case if these are boots
      movement_speed = item_stats[3].scan(/(\d+) Movement Speed/).flatten.first
      stats.merge!(movement_speed: movement_speed)  if movement_speed.present?

      # Has spell vamp?
      spell_vamp =  item_stats[3].scan(/(\d+)% Spell Vamp/).flatten.first
      stats.merge!(spell_vamp: spell_vamp) if spell_vamp.present?
      
      # Has cooldown reduction?
      cooldown_reduction = item_stats[3].scan(/(\d+)% Cooldown Reduction/).flatten.first
      stats.merge!(cooldown_reduction: cooldown_reduction) if cooldown_reduction.present?

      desc.flatten.each do |stat|
        value = stat.scan(/\d+/).flatten.first
        key = stat.gsub("#{value} ", '').downcase.gsub(' ', '_').to_sym
        stats.merge!(key => value)
      end
      item_stats = { image: image, 
                     name: name, 
                     cost: cost, 
                     stats: stats, 
                     passive: uniques
                    }
  end
end
