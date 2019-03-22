# FactoryBot.define do
#
#   # post factory with a `belongs_to` association for the user
#   factory :review do
#     sequence(:title) { |n| "Title #{n}" }
#     rating { 0 }
#     sequence(:text) { |n| "text_#{n}" }
#     book
#
#
#
#     sequence(:title) { |n| "Title_#{n}" }
#     sequence(:number_of_pages) { |n| n*50 }
#     sequence(:year_published) { |n| n }
#     sequence(:book_cover_url) { |n| "book_cover_url_#{n}" }
#     user
#   end
#
#   # user factory without associated posts
#   factory :user do
#     name { "John Doe" }
#
#     # user_with_posts will create post data after the user has been created
#     factory :user_with_posts do
#       # posts_count is declared as a transient attribute and available in
#       # attributes on the factory, as well as the callback via the evaluator
#       transient do
#         posts_count { 5 }
#       end
#
#       # the after(:create) yields two values; the user instance itself and the
#       # evaluator, which stores all values from the factory, including transient
#       # attributes; `create_list`'s second argument is the number of records
#       # to create and we make sure the user is associated properly to the post
#       after(:create) do |user, evaluator|
#         create_list(:post, evaluator.posts_count, user: user)
#       end
#     end
#   end
# end
