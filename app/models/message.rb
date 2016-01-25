class Message < ActiveRecord::Base
  belongs_to :conversation, touch: true
  belongs_to :user

  validates_presence_of :text, :conversation_id, :user_id
end