json.array!(@feedbacks) do |feedback|
  json.extract! feedback, :id, :subject_id_id, :writer_id_id, :text, :rating, :work_offer_id
  json.url feedback_url(feedback, format: :json)
end
