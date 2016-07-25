class Task < ActiveRecord::Base
  belongs_to :user
  has_many :reverse_relationships, foreign_key: 'task_id',
                                   class_name:  'Relationship'
  has_many :followers, through: :reverse_relationships, source: :follower
  default_scope -> { order('updated_at DESC') }
  validates :content, presence: true, length: { maximum: 500 }
  validates :user_id, presence: true
end
