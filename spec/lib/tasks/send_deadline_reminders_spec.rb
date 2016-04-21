require 'spec_helper'
require 'rake'

describe 'send_deadline_reminders' do
  let(:invoke_task) do
    Rake::Task['send_deadline_reminders:all'].reenable
    Rake.application.invoke_task 'send_deadline_reminders:all'
  end

  before do
    Rake.application.rake_require 'tasks/send_deadline_reminders'
    Rake::Task.define_task(:environment)
  end

  it 'functions properly' do
    2.times { invoke_task }
  end
end
