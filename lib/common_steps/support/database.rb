require 'database_cleaner'
DatabaseCleaner.strategy = :truncation

Before do
  DatabaseCleaner.start
  
  ::Rake::Task["db:test:load_contents"].execute if ::Rake::Task.task_defined?("db:test:load_contents")
end
 
After do
  DatabaseCleaner.clean
end
