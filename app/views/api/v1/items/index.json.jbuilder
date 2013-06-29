json.array!(@items) do |json, item|
  json.partial! item
end