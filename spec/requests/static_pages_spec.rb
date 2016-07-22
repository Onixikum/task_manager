require 'spec_helper'

describe 'Static pages' do
  subject { page }

  describe 'Home page' do
    before { visit root_path }

    it { should have_title(full_title('')) }
    it { should_not have_title('|') }

    describe 'for signed-in users' do
      let(:user) { FactoryGirl.create(:user) }
      before do
        FactoryGirl.create(:task, user: user, content: 'Tra la')
        FactoryGirl.create(:task, user: user, content: 'La la')
        sign_in user
        visit root_path
      end

      it "shoud render the user's feed" do
        user.feed.each do |item|
          expect(page).to have_selector("li##{item.id}", text: item.content)
        end
      end
    end
  end

  it 'shoud have the right links on the layout' do
    visit root_path
    first('.container').click_link 'Home'
    click_link 'Sign up now!'
    expect(page).to have_title(full_title('Sign Up'))
    first('.container').click_link 'TaskManager'
    expect(page).to have_title(full_title(''))
    first('.footer').click_link 'TaskManager'
    expect(page).to have_title(full_title(''))
    first('.footer').click_link 'Home'
    expect(page).to have_title(full_title(''))
  end
end
