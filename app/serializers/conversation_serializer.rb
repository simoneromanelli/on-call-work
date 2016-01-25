class ConversationSerializer < ActiveModel::Serializer
  attributes :id, :sender_id, :recipient_id
  has_many :messages
end
