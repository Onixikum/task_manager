class User < ActiveRecord::Base #:nodoc:
  has_many :tasks
  has_many :relationships, foreign_key: 'follower_id'
  has_many :followed_tasks, through: :relationships, source: :task
  before_save { email.downcase! }
  before_create :create_remember_token
  validates :name, presence: true, length: { maximum: 25 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, length: { minimum: 6 }

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  def feed
    self.followed_tasks
  end

  def following?(task)
    relationships.find_by(task_id: task.id)
  end

  def follow!(task)
    relationships.create!(task_id: task.id)
  end

  def unfollow!(task)
    relationships.find_by(task_id: task.id).destroy!
  end

  private

  def create_remember_token
    self.remember_token = User.encrypt(User.new_remember_token)
  end
end
