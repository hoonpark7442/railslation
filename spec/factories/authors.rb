FactoryBot.define do
  factory :author do
    name { "MyString" }
    description { "MyString" }
    author_type { 1 }
    website_url { "MyString" }
    feed_url { "MyString" }
    nationality { 1 }
    feed_fetched_at { "2022-05-16 12:15:04" }
  end
end
