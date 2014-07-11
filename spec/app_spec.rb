require "spec_helper"

  feature "Homepage" do
    scenario "Homepage to say contacts" do
      visit "/"

    expect(page).to have_content("Contacts:")
    expect(page).to have_button("Login")
    click_button("Login")
    end
  end

  feature "Login" do
    scenario "Login page has login form" do
      visit "/login"
      expect(page).to have_field("username")
      expect(page).to have_field("password")

    fill_in("username", :with => "Hunter")
    fill_in("password", :with => "puglyfe")

    click_button("Submit")
      expect(page).to have_content("Welcome, Hunter!")
      expect(page).to have_content("Kirsten", "kirsten@example.com")
    end
  end



