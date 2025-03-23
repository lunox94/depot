module AuthenticationTestHelper
  def login_as(user)
    find("#email_address").fill_in with: user.email_address
    find("#password").fill_in with: "password"
    click_on "Sign in"
  end
end
