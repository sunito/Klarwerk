#!/usr/bin/env rake
# encoding: UTF-8

# require(File.join(File.dirname(__FILE__), 'config', 'boot'))
require File.expand_path('../config/application', __FILE__)
  
Klarwerk::Application.load_tasks

# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.
=begin
require(File.join(File.dirname(__FILE__), 'config', 'boot'))


require 'rake'
require 'rake/testtask'
#require 'rake/rdoctask'
#require 'rdoc/task'

require 'tasks/rails'
=end

[1, 2].each do |db_num|
db_id = "db#{db_num}".to_sym
db_conf = [nil, "db1", "messpunkte"][db_num]
namespace db_id do
  desc "Migriere die #{db_num}. Messpunkte-Datenbank (#{db_id})"
  task :migrate => :environment do
    ActiveRecord::Base.establish_connection(ActiveRecord::Base.configurations[db_conf])
    ActiveRecord::Migration.verbose = ENV["VERBOSE"] ? ENV["VERBOSE"] == "true" : true
    ActiveRecord::Migrator.migrate("#{db_id}/migrate/", ENV["VERSION"] ? ENV["VERSION"].to_i : nil)
    Rake::Task["#{db_id}:schema:dump"].invoke if ActiveRecord::Base.schema_format == :ruby
  end

  namespace :schema do
    desc "Create a #{db_id}/schema.rb file that can be portably used against any DB supported by AR"
    task :dump => :environment do
      require 'active_record/schema_dumper'
      ActiveRecord::Base.establish_connection(ActiveRecord::Base.configurations[db_conf]) 
      File.open("#{::Rails.root}/#{db_id}/schema.rb", "w") do |file|
        ActiveRecord::SchemaDumper.dump(ActiveRecord::Base.connection, file)
      end
      Rake::Task["#{db_id}:schema:dump"].reenable
    end

    desc "Load a schema.rb file into the database"
    task :load => :environment do
       ActiveRecord::Base.establish_connection(ActiveRecord::Base.configurations[db_conf])
#      file = ENV['SCHEMA'] || "#{RAILS_ROOT}/db2/schema.rb"
      file = "#{::Rails.root}/#{db_id}/schema.rb"
      if File.exists?(file)
        load(file)
      else
        abort %{#{file} doesn't exist yet. Run "rake #{db_id}:migrate" to create it then try again. If you do not intend to use a database, you should instead alter #{RAILS_ROOT}/config/environment.rb to prevent active_record from loading: config.frameworks -= [ :active_record ]}
      end
    end
  end
end
end
