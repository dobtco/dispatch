desc 'Queues a UserSearchResultsJob job for each user'
task queue_user_search_results: :environment do
  User.find_each do |user|
    UserSearchResultsJob.perform_later(user)
  end
end
