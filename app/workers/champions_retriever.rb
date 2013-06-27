class ChampionsRetriever
  include Sidekiq::Worker
  sidekiq_options retry: 8

  def perform()
  	html = Nokogiri::HTML(open('http://leagueoflegends.wikia.com/wiki/Base_champion_statistics'))
    images = Nokogiri::HTML(open('http://www.mobafire.com/league-of-legends/champions'))
    length = html.at_css('table.wikitable.sortable').children().length

    i = 1
    html.at_css('table.wikitable.sortable').children()[1..length-1].each do |champion|
      image = images.at_css('div.self-clear#browse-build').children()[i].children[1].get_attribute('src')
      stats = Champion.parse(champion, image)
      champion_instance = Champion.find_or_initialize_by_name(stats[:name])
      champion_instance.update_attributes(stats)
      i += 2
    end
  end
end