json.array!(@site_array) do |site|
    json.site_id        site[0]
    json.site_name      site[1]
    json.telephone_num  site[2]
end