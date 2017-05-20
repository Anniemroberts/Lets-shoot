class User < ApplicationRecord
  mount_uploader :image, ImageUploader

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  searchkick text_start: [:first_name, :last_name]

  has_many :notifications, foreign_key: :recipient_id

  has_many :jobs, dependent: :nullify

  has_many :applications, dependent: :destroy
  has_many :jobs_applied, through: :applications, source: :job

  has_many :chatroom_users
  has_many :chatrooms, through: :chatroom_users
  has_many :messages

  has_many :friendships
  has_many :received_friendships, class_name: "Friendship", foreign_key: "friend_id"

  has_many :active_friends, -> { where(friendships: { accepted: true}) }, through: :friendships, source: :friend
  has_many :received_friends, -> { where(friendships: { accepted: true}) }, through: :received_friendships, source: :user

  has_many :pending_friends, -> { where(friendships: { accepted: false}) }, through: :friendships, source: :friend
  has_many :requested_friendships, -> { where(friendships: { accepted: false}) }, through: :received_friendships, source: :user


  def friends
    active_friends | received_friends
  end


  def pending
    pending_friends | requested_friendships
  end



  before_validation :downcase_email

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true,
                    uniqueness: true,
                    format: VALID_EMAIL_REGEX,
                    unless: :from_omniauth?

  def full_name
    "#{first_name} #{last_name}".strip.titleize
  end


  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid      = auth.uid
      user.email = auth.email
      user.first_name = auth.info.first_name
      user.last_name = auth.info.last_name
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.password = SecureRandom.hex(16)
      user.save!
    end
  end

  def self.authenticate (email, password)
    user = find_by_email(email)
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
        user
    else
        nil
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def from_omniauth?
    uid.present? && provider.present?
  end

  def downcase_email
    self.email&.downcase!
  end
end

# has_many :friendships
# has_many :received_friendships, class_name: "Friendship", foreign_key: "friend_id"
# has_many :active_friends, -> { where(friendships: { accepted: true}) }, through: :friendships, source: :friend
# has_many :received_friends, -> { where(friendships: { accepted: true}) }, through: :received_friendships, source: :user
# has_many :pending_friends, -> { where(friendships: { accepted: false}) }, through: :friendships, source: :friend
# has_many :requested_friendships, -> { where(friendships: { accepted: false}) }, through: :received_friendships, source: :user
