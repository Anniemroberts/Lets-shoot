class Application < ApplicationRecord
  include AASM
  belongs_to :user
  belongs_to :job

  aasm do
     state :Submitted, initial: true
     state :Hired

     state :Submitted do
       validates(:body, presence: true, length: { minimum: 3})
     end

     event :accept do
       transitions from: :Submitted, to: :Hired
     end
   end

end
