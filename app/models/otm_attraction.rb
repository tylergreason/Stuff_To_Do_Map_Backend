class OtmAttraction < ApplicationRecord

    # @@metro_url ||= 'https://collectionapi.metmuseum.org/public/collection/v1/search?q=hasImage=true'
    # create rest response for it 
    # @@metro_response ||= RestClient.get(@@metro_url)
    # turn that into JSON
    # @@metro_images ||= JSON.parse(@@metro_response)

    def self.otm_attractions_in_bounds(north,east,south,west) 
        # create otm url 
        otm_url = self.create_otm_url(north,east,south,west) 
        # get data from that url
        otm_data = RestClient.get(otm_url)
        p otm_data
        # then parse it into JSON 
        JSON.parse(otm_data)
    end

    def self.create_otm_url(north,east,south,west)
        # url = %Q(https://api.opentripmap.com/0.1/en/places/bbox?lon_min=#{west}&lon_max=#{east}&lat_min=#{south}&lat_max=#{north}&kinds=historical_places&src_attr=wikidata&apikey=#{ENV['OTM_API_KEY']})
        url = 'https://api.opentripmap.com/0.1/en/places/bbox?lon_min=' + west.to_s + '&lon_max=' + east.to_s + '&lat_min=' + south.to_s + '&lat_max=' + north.to_s + '&kinds=historical_places&src_attr=wikidata&apikey=' + ENV['OTM_API_KEY']
    end

    def self.fetch_wikidata(xid)
        url = 'https://api.opentripmap.com/0.1/en/places/xid/' + xid + '?apikey=' + ENV['OTM_API_KEY']
        wikidata_data = RestClient.get(url)
        # return data as json 
        wikidata_json = JSON.parse(wikidata_data)
        p wikidata_json 
        return wikidata_json
    end
end
