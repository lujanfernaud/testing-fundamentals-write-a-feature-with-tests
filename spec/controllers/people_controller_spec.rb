require "rails_helper"

describe PeopleController do
  describe "#create" do
    context "when person is valid" do
      it "redirects to #show" do
        person = person_to_create

        post :create, person: { first_name: "Bob" }

        expect(response).to redirect_to person_path(person)
      end
    end

    context "when person is invalid" do
      it "redirects to #new" do
        person = person_to_create is_valid: false

        post :create, person: { first_name: "" }

        expect(response).to render_template :new
      end
    end
  end

  describe "#update" do
    context "when person is valid" do
      it "redirects to #show" do
        person = person_to_update

        patch :update, id: person.id, person: { first_name: "Bob"}

        expect(response).to redirect_to person_path(person)
      end
    end

    context "when person is invalid" do
      it "redirects to #edit" do
        person = person_to_update is_valid: false

        patch :update, id: person.id, person: { first_name: "" }

        expect(response).to render_template :edit
      end
    end
  end

  private

  def person_to_create(is_valid: true)
    person_double = Person.create(first_name: "Bob")

    allow(Person).to receive(:new).and_return(person_double)
    allow(person_double).to receive(:save).and_return(is_valid)

    person_double
  end

  def person_to_update(is_valid: true)
    person_double = Person.create(first_name: "Bob")

    allow(Person).to receive(:find).and_return(person_double)
    allow(person_double).to receive(:update_attributes).and_return(is_valid)

    person_double
  end
end
