FactoryBot.define do
  factory :rss_feed do
    author { nil }
    title { "MyString" }
    feed_source_url { "MyString" }
    published_at { "2022-05-16 12:45:54" }
    cached_tag_list { "MyString" }
    translated { false }
  end
end
