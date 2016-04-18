namespace :db do
  namespace :seed do
    desc "seed example data"
    task example: :environment do
      FactoryGirl.create(
        :user,
        name: 'Demo User',
        email: 'admin@example.com',
        permission_level: 'admin',
        confirmed_at: Time.now
      )
    end
  end

  all = [:environment, :drop, :create, 'structure:load', :seed, 'seed:example']

  task all: all
  task all_via_migration: all.map! { |x| x == 'structure:load' ? :migrate : x }
end
