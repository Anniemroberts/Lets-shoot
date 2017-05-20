class Job < ApplicationRecord
  include AASM

  belongs_to :user
  has_many :applications, dependent: :nullify
  scope :reversed, -> { order 'created_at DESC' }

  searchkick text_start: [:title, :show], suggest: [:title, :show]

  validates(:title, { presence: { message: 'must be given!' },
                    uniqueness: true })

 geocoded_by :address
 after_validation :geocode

 aasm do
    state :Open, initial: true
    state :Filled

    state :Open do
      validates(:title, presence: true, length: { minimum: 3})
    end

    event :fill do
      transitions from: :Open, to: :Filled
    end
  end
end
