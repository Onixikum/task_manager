require 'spec_helper'

describe "Static pages" do

  subject { page }

  describe "Home page" do
    before { visit root_path }

    it { should have_selector('h1', 'Welcom to the Task Manager') }
    it { should have_title(full_title('')) }
    it { should_not have_title('|') }
  end

  it "shoud have the right links on the layout" do
    visit root_path
    first('.container').click_link "Home"
    click_link "Sign up now!"
    expect(page).to have_title(full_title('Sign up'))
    first('.container').click_link "TaskManager"
    expect(page).to have_title(full_title(''))
    first('.footer').click_link "TaskManager"
    expect(page).to have_title(full_title(''))
    first('.footer').click_link "Home"
    expect(page).to have_title(full_title(''))
  end
end