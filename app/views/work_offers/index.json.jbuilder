json.array!(@work_offers) do |work_offer|
  json.extract! work_offer, :id, :title, :description, :company, :date_time, :bidder_id, :elected_id
  json.url work_offer_url(work_offer, format: :json)
end
