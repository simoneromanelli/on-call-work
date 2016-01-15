class WorkOfferSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :company_name, :date_time
  has_one :bidder
  has_one :elected
end
