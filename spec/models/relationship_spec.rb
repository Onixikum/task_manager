require 'spec_helper' #:nodoc:

describe Relationship do
  let(:user) { FactoryGirl.create(:user) }
  let(:task) { FactoryGirl.create(:task, user: user) }
  let(:follower) { FactoryGirl.create(:user, email: 'folover@mail.com') }
  let(:relationship) { follower.relationships.build(task_id: task.id) }

  subject { relationship }

  it { should be_valid }

  describe 'when task id is not present' do
    before { relationship.task_id = nil }
    it { should_not be_valid }
  end

  describe 'when follower id is not present' do
    before { relationship.follower_id = nil }
    it { should_not be_valid }
  end
end
