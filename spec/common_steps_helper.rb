require "rubygems"
require 'spec'
require 'spec/mocks'
 
require "facets"
require "ruby-debug"
Debugger.start
 

require "active_record"
ActiveRecord::Schema.verbose = false
ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :database => ":memory:")
ActiveRecord::Base.configurations = true
ActiveRecord::Schema.define(:version => 1) do
  create_table "artists", :force => true do |t|
    t.string "name"
    t.integer "age"
    t.timestamps
  end
end

Object.send(:remove_const, :Artist) if defined?(Artist)
class Artist < ActiveRecord::Base
end

require 'cucumber'
require 'factory_girl'

Factory.define :artist do |f|
end
