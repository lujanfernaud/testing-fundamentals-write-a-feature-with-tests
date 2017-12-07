require "rails_helper"

feature "user creates person" do
  scenario "with valid data" do
    visit new_person_path

    fill_in "person_first_name", with: "Bob"
    click_button "Create Person"

    expect(page).to have_content("Person created")
  end

  scenario "with invalid data" do
    visit new_person_path

    fill_in "person_first_name", with: ""
    click_button "Create Person"

    expect(page).to have_content("First name can't be blank")
  end
end

feature "user edits existing person" do
  scenario "with valid data" do
    person = Person.create(first_name: "B.")

    visit edit_person_path(person.id)

    fill_in "person_first_name", with: "Bob"
    click_button "Update Person"

    expect(page).to have_content("Person updated")
  end

  scenario "with invalid data" do
    person = Person.create(first_name: "B.")

    visit edit_person_path(person.id)

    fill_in "person_first_name", with: ""
    click_button "Update Person"

    expect(page).to have_content("First name can't be blank")
  end
end
