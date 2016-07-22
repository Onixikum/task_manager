class Task < ActiveRecord::Base
  belongs_to :user
  default_scope -> { order('updated_at DESC') }
  validates :content, presence: true, length: { maximum: 500 }
  validates :user_id, presence: true
end
