require "application_system_test_case"
require_relative "helpers/authentication_test_helper"

class UsersTest < ApplicationSystemTestCase
  include AuthenticationTestHelper

  setup do
    @user = users(:one)
  end

  test "visiting the index" do
    visit users_url

    login_as @user

    assert_selector "h1", text: "Users"
  end

  test "should create user" do
    visit users_url

    login_as @user

    click_on "New user"

    fill_in "Email address", with: "new_test_address@example.com"
    fill_in "Name", with: "new_name"
    fill_in "Password", with: "secret"
    fill_in "Confirm", with: "secret"
    click_on "Create User"

    assert_text "User new_name was successfully created"
  end

  test "should update User" do
    visit user_url(@user)

    login_as @user

    click_on "Edit this user", match: :first

    fill_in "Email address", with: @user.email_address
    fill_in "Name", with: @user.name
    find("#user_password").fill_in with: "secret"
    fill_in "Confirm", with: "secret"
    fill_in "Current Password", with: "password"
    click_on "Update User"

    assert_text "User #{@user.name} was successfully updated"
  end

  test "should destroy User" do
    visit user_url(@user)

    login_as @user

    accept_alert "Are you sure?" do
      click_on "Destroy this user", match: :first
    end

    assert_text "User #{@user.name} was successfully destroyed"
  end
end
