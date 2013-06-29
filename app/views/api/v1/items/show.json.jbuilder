json.extract! @item, :id, :name, :image, :cost
json.stats @item.stats
json.special @item.passive