json.array!(@sites) do |site|
  json.extract! site, :id, :site_num, :site_name, :telephone_num
  json.url site_url(site, format: :json)
end
