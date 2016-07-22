require 'spec_helper'

describe Task do

  let(:user) { FactoryGirl.create(:user) }
  before { @task = user.tasks.build(content: "One task") }

  subject { @task }

  it { should respond_to(:content) }
  it { should respond_to(:user_id) }

  it { should be_valid }

  describe "when user_id is not present" do
    before { @task.user_id = nil }
    it { should_not be_valid }
  end

  describe "with blank content" do
    before { @task.content = nil }
    it { should_not be_valid }
  end

  describe "with content that is too long" do
    before { @task.content = "a" * 501 }
    it { should_not be_valid }
  end
end