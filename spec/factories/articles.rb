FactoryBot.define do
  sequence(:title) { |n| "#{Faker::Book.title}#{n}" }

  factory :article do
    published_at { Time.current }

    transient do
      title           { generate :title }
      published       { true }
      date            { "04/30/2022" }
      tags            { "javascript, html, discuss" }
      with_date       { false }
      with_tags       { true }
      with_title      { true }
      with_collection { nil }
    end

    association :user, factory: :user, strategy: :create
    description { Faker::Hipster.paragraph(sentence_count: 1)[0..100] }
    body_markdown do
      <<~HEREDOC
        ---
        title: #{title if with_title}
        published: #{published}
        tags: #{tags if with_tags}
        date: #{date if with_date}
        series: #{with_collection&.slug if with_collection}
        ---

        #{Faker::Hipster.paragraph(sentence_count: 3)}
      HEREDOC
    end

  end
end
