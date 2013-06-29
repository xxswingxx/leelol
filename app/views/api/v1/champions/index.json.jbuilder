json.array!(@champions) do |json, champion|
  json.partial! champion
end