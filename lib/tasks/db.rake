namespace :db do
  namespace :seed do
    desc "seed example data"
    task example: :environment do
    end
  end

  all = [:environment, :drop, :create, 'structure:load', :seed, 'seed:example']

  task all: all
  task all_via_migration: all.map! { |x| x == 'structure:load' ? :migrate : x }
end
