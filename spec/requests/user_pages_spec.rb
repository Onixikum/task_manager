require 'spec_helper'

describe "User pages" do

  subject { page }

  describe "index" do
    let(:user) { FactoryGirl.create(:user) }
    before(:each) do
      sign_in user
      visit users_path
    end

    it { should have_title('All users') }
    it { should have_content('All users') }

    describe "pagination" do
      before(:all) { 30.times { FactoryGirl.create(:user) } }
      after(:all)  { User.delete_all }

      it { should have_selector('div.pagination') }

      it "should list each user" do
        User.paginate(page: 1).each do |user|
          expect(page).to have_selector('li', text: user.name)
        end
      end
    end
  end
  
  describe "profile page" do
    let(:user) { FactoryGirl.create(:user) }
    let!(:task1) { FactoryGirl.create(:task, user: user, content: "Tra") }
    let!(:task2) { FactoryGirl.create(:task, user: user, content: "La la") }

    before { visit user_path(user) }

    it { should have_title(user.name) }
    it { should have_content(user.name) }
    it { should have_content(user.email) }

    describe "tasks" do
      it { should have_content(task1.content) }
      it { should have_content(task2.content) }
      it { should have_content(user.tasks.count) }
    end
  end

  describe "signup page" do
    before { visit signup_path }

    it { should have_content('Sign Up') }
    it { should have_title(full_title('Sign Up')) }
  end

  describe "signup page" do
    before { visit signup_path }

    let(:submit) { "Create my account" }

    it { should have_selector('h1', text: 'Sign Up') }
    it { should have_title(full_title('Sign Up')) }

    describe "with invalid information" do

      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end

      describe "after submission" do
        before { click_button submit }

        it { should have_title('Sign Up') }
        it { should have_content('error') }
      end
    end

    describe "wiht valid information" do
      before do
        fill_in "Name",         with: "User1"
        fill_in "Email",        with: "user1@mail.com"
        fill_in "Password",     with: "xxxxxx"
        fill_in "Confirm Password", with: "xxxxxx"
      end

      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end

      describe "after saving the user" do
        before { click_button submit }
        let(:user) { User.find_by(email: 'user1@mail.com') }

        it { should have_link('Sign out') }
        it { should have_title(user.name) }
        it { should have_selector('div.alert.alert-success', text: 'Welcome') }
      end
    end
  end

  describe "edit" do
    let(:user) { FactoryGirl.create(:user) }
    before do
      sign_in user
      visit edit_user_path(user) 
    end

    describe "page" do
      it { should have_content("Update your profile") }
      it { should have_title("Edit user") }
    end

    describe "with invalid information" do
      before { click_button "Save changes" }

      it { should have_content('error') }
    end

    describe "with valid information" do
      let(:new_name)  { "New Name" }
      let(:new_email) { "new@example.com" }
      before do
        fill_in "Name",             with: new_name
        fill_in "Email",            with: new_email
        fill_in "Password",         with: user.password
        fill_in "Confirm Password", with: user.password
        click_button "Save changes"
      end

      it { should have_title(new_name) }
      it { should have_selector('div.alert.alert-success') }
      it { should have_link('Sign out', href: signout_path) }
      specify { expect(user.reload.name).to eq new_name }
      specify { expect(user.reload.email).to eq new_email }
    end
  end
end