class Relationship < ActiveRecord::Base #:nodoc:
  belongs_to :follower, class_name: 'User'
  belongs_to :task, class_name: 'Task'
  validates :follower_id, presence: true
  validates :task_id, presence: true
end
