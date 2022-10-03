require 'database_cleaner'

shared_context "db_cleanup" do
  before(:all) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end
end
shared_context "db_scope" do
  before(:each) do
    DatabaseCleaner.start
  end
  after(:each) do
    DatabaseCleaner.clean
  end
end
