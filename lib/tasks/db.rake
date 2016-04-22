namespace :db do
  namespace :seed do
    desc 'seed example data'
    task example: :environment do
      user = FactoryGirl.create(
        :user,
        name: 'Demo User',
        email: 'admin@example.com',
        permission_level: 'admin',
        confirmed_at: Time.now
      )

      departments = Array(3).map { FactoryGirl.create(:department) }

      categories = Array(10).map { FactoryGirl.create(:category) }

      opp = FactoryGirl.create(
        :opportunity,
        :published,
        :approved,
        created_by_user: user,
        department: departments.sample,
        submissions_open_at: Time.now + 1.day,
        submissions_close_at: Time.now + 1.month
      )

      opp.categories = categories.sample(2)

      opp_two = FactoryGirl.create(
        :opportunity,
        :published,
        created_by_user: user,
        department: departments.sample
      )

      opp_two.categories << categories.sample
    end
  end

  all = [:environment, :drop, :create, 'structure:load', :seed, 'seed:example']

  task all: all
  task all_via_migration: all.map! { |x| x == 'structure:load' ? :migrate : x }
end
