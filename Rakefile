require 'rake/testtask'

Rake::TestTask.new(:test) do |t|
  t.test_files = FileList["test/*_test.rb"]
  t.warning = false
end

task default: :test
