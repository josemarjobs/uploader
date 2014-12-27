require "rake/testtask"

Rake::TestTask.new do |t|
  t.pattern = "test/**/*_test.rb"
  t.libs << "lib"
  t.libs << "test"
end

task default: [:test, "db:migrate"]

namespace :db do
  desc "Migrate the database"
  task :migrate do
    system "sequel -m db/migrate sqlite://db/db.sqlite3"
  end
end

desc "Start the application"
task :start do
  system "rackup config.ru"
end