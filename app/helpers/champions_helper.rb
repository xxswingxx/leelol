module ChampionsHelper
  def items_collection
    Item.all.map { |i| [i.name, i.id] }
  end
end
