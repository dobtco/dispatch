namespace :db do
  namespace :seed do
    desc "seed example data"
    task example: :environment do
      user = FactoryGirl.create(
        :user,
        name: 'Demo User',
        email: 'admin@example.com',
        permission_level: 'admin',
        confirmed_at: Time.now
      )

      department = FactoryGirl.create(:department)

      FactoryGirl.create(:category)

      FactoryGirl.create(
        :opportunity,
        :published,
        :approved,
        created_by_user: user,
        department: department
      )

      FactoryGirl.create(
        :opportunity,
        :published,
        created_by_user: user,
        department: department
      )
    end
  end

  all = [:environment, :drop, :create, 'structure:load', :seed, 'seed:example']

  task all: all
  task all_via_migration: all.map! { |x| x == 'structure:load' ? :migrate : x }
end
