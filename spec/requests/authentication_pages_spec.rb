require 'spec_helper'

describe "Authentication" do
  subject { page }

  describe "signin page" do
    before { visit signin_path }

    it { should have_content('Sign in') }
    it { should have_title('Sign in') }
  end

  describe "signin" do
    before { visit signin_path }
    let(:submit) { "Sign in" }

    describe "with invalid information" do
      describe "blank input" do
        before { click_button submit }

        it { should have_content('Sign in') }
        it { should have_error_message('Invalid') }

        describe "after visiting another page" do
          before { click_link "Home" }
          it { should_not have_error_message('Invalid') }
        end
      end

      describe "incorrect email" do
        before do
          fill_in "Email", with: "example"
          click_button submit
        end

        it { should have_content('Sign in') }
        it { should have_error_message('Invalid') }
      end

      describe "incorrect password" do
        let(:user) { FactoryGirl.create(:user) }
        before do
          fill_in "Email",    with: user.email.downcase
          fill_in "Password", with: "example"
          click_button submit
        end

        it { should have_content('Sign in') }
        it { should have_error_message('Invalid') }
      end
    end

    describe "with valid information" do
      let(:user) { FactoryGirl.create(:user) }
      before { valid_signin(user) }

      it { should have_title(user.name) }
      it { should have_user_menu }

      describe "followed by signout" do
        before { click_link "Sign out" }

        it { should_not have_user_menu }
      end
    end
  end

end
