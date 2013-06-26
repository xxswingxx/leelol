class Item < ActiveRecord::Base

  serialize :stats, Hash
  serialize :passive, Array

  #default_scope order('name ASC')

  def self.parse(item_stats)
    stats_and_uniques = img.children.children.at_css('img').get_attribute('data-descr').split('  ')

    stats = stats_and_uniques.first.scan(/(\+\d+\%?[\s\w*]+)/)
    stats_hash = {}
    stats.each do |stat|
      value = stat.first.match(/^\+\d+/)[0]
      key = stat.first.gsub(/^\+\d+/, '').strip.downcase.gsub(' ', '_').to_sym
      stats_hash.merge!({ key => value })
    end

    passives = []
    if stats_and_uniques.length > 1
      stats_and_uniques[1..stats_and_uniques.length - 1].each do |unique|
        if unique =~ /((Passive|Aura)|Augment)/
          passives << unique 
        else
          @active = unique
        end
      end
    end

    { name: img.children.children.at_css('img').get_attribute('data-name'), 
      image: img.children.children.at_css('img').get_attribute('data-img'), 
      stats: stats_hash, 
      passive: passives, 
      active: @active,
      cost: img.children.children.at_css('img').get_attribute('data-cost') }
  end
end
