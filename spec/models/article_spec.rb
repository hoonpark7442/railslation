require 'rails_helper'

RSpec.describe Article, type: :model do
  # def build_and_validate_article(*args)
  #   article = build(:article, *args)
  #   article.validate!
  #   article
  # end

  let(:user) { create(:user) }
  let!(:article) { create(:article, user: user) }

  describe "validation" do
    subject { build(:article) }
    subject(:invalid_title){ build(:article, title: "") }

    it { is_expected.to belong_to(:collection).optional }
    it { is_expected.to belong_to(:user) }

    it { is_expected.to validate_length_of(:body_markdown).is_at_least(0) }

    it "is invalid if title is nill" do
      expect(invalid_title).to_not be_valid
    end
    # it { is_expected.to validate_length_of(:title).is_at_most(128) }
    # it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:user_id) }

    it { is_expected.to validate_uniqueness_of(:slug).scoped_to(:user_id) }

    context "when published" do
      before do
        # rubocop:disable RSpec/NamedSubject
        allow(subject).to receive(:published?).and_return(true) # rubocop:disable RSpec/SubjectStub
        # rubocop:enable RSpec/NamedSubject
      end

      it { is_expected.to validate_presence_of(:slug) }
    end
  end
  
end
