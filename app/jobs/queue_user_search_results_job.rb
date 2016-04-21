class QueueUserSearchResultsJob < ApplicationJob
  def perform
    User.find_each do |user|
      UserSearchResultsJob.perform_later(user)
    end
  end
end
