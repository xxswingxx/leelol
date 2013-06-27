class ItemsRetriever
  include Sidekiq::Worker
  sidekiq_options retry: 8

  def perform
    html = Nokogiri::HTML(open('http://www.mobafire.com/league-of-legends/items'))

    html.at_css('#browse-items').css('a.champ-box').each do |item|
      stats = Item.parse(item)
      item_instance = Item.find_or_initialize_by_name(stats[:name])
      item_instance.update_attributes(stats)
    end
  end
end