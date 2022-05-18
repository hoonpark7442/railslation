require "rails_helper"

RSpec.describe Articles::Builder, type: :service do
  let(:user) { create(:user) }

  context "builder is called" do
    let(:user) { create(:user) }
    let(:correct_attributes) do
      body_markdown = "---\ntitle: \npublished: false\ndescription: \ntags: " \
             "\nseries: \ntranslation: \n---\n\n"

      {
        body_markdown: body_markdown,
        processed_html: "",
        user_id: user.id
      }
    end

    it "initializes an article with the correct attributes" do
      subject = described_class.call(user)

      expect(subject).to be_an_instance_of(Article)
      expect(subject).to have_attributes(correct_attributes)
    end
  end
end
