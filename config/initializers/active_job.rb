# Monkeypatch ActiveJob:
#
#  - Adds :super_inline adapter, which runs all jobs immediately, even if
#    they're queued for the future
module ActiveJob
  module QueueAdapters
    class SuperInlineAdapter < InlineAdapter
      class << self
        def enqueue_at(job, _)
          enqueue(job)
        end
      end
    end
  end
end

# Set queue adapter *before* newrelic_rpm loads:
# https://github.com/rails/rails/issues/19801
inline_envs = %w(test development)

ActiveJob::Base.queue_adapter = if Rails.env.in?(inline_envs)
                                  :super_inline
                                else
                                  :resque
                                end
