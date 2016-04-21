# rubocop:disable all
guard :rspec, all_on_start: false, all_after_pass: false, failed_mode: :focus, cmd: 'bin/rspec' do
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^lib/(.+)\.rb$})                     { |m| "spec/lib/#{m[1]}_spec.rb" }
  watch(%r{^app/(.+)\.rb$})                     { |m| "spec/#{m[1]}_spec.rb" }
  watch(%r{^app/controllers/api/(.+)\.rb$})     { |m| "spec/api/#{m[1]}_spec.rb" }
  watch(%r{^app/views/(.+)\.rb$})               { |m| "spec/views/#{m[1]}_spec.rb" }
end

guard :livereload do
  watch(%r{app/views/.+\.(erb)$})
  watch(%r{themes/(.+)/assets/\w+/(.+)\.(scss)})
  watch(%r{(app|vendor)(/assets/\w+/(.+)\.(scss))})
end

guard :rubocop, all_on_start: false do
  watch(%r{.+\.rb$})
  watch(%r{(?:.+/)?\.rubocop\.yml$}) { |m| File.dirname(m[0]) }
end
