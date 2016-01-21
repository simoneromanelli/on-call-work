class Conversation < ActiveRecord::Base
  validates :sender_id, :recipient_id, presence: true
  validate :users_coherence

  belongs_to :sender, class_name: 'User', foreign_key: 'sender_id'
  belongs_to :recipient, class_name: 'User', foreign_key: 'recipient_id'

  def users_coherence
    sender = User.find(sender_id)
    recipient = User.find(recipient_id)

    !((sender.employer? && recipient.employee?) ||
      (sender.employee? && recipient.employer?)) && errors
        .add(
          :base,
          'Conversations can only happend between employer and employee'
        )
  end
end
