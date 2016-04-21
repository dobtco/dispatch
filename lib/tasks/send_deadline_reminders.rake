desc 'Send all deadline reminders'
namespace :send_deadline_reminders do
  task all: [:questions, :submissions]

  desc 'Send deadline reminders for question deadlines'
  task questions: :environment do
    puts 'q'
  end

  desc 'Send deadline reminders for submissions deadlines'
  task submissions: :environment do
    puts 's'
  end
end
