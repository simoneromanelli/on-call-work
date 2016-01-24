class Conversation < ActiveRecord::Base
  validates :sender_id, :recipient_id, presence: true
  validates_uniqueness_of :sender_id, scope: :recipient_id
  validate :users_coherence

  belongs_to :sender, class_name: 'User', foreign_key: :sender_id
  belongs_to :recipient, class_name: 'User', foreign_key: :recipient_id
  # has many :users through custom method

  has_many :messages, dependent: :destroy

  default_scope { where('archived = false') }

  scope :between, -> (sender_id, recipient_id) do
    where(
      "(conversations.sender_id = ? AND conversations.recipient_id =?)
      OR (conversations.sender_id = ? AND conversations.recipient_id =?)
      AND conversations.archived = true",
      sender_id,
      recipient_id,
      recipient_id,
      sender_id
    )
  end

  def users
    User.where(
      'id = :sender_id OR id = :recipient_id',
      sender_id: sender_id,
      recipient_id: recipient_id
    )
  end

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
