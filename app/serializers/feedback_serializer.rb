class FeedbackSerializer < ActiveModel::Serializer
  attributes :id, :text, :rating, :created_at
end
