# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require(File.join(File.dirname(__FILE__), 'config', 'boot'))


require 'rake'
require 'rake/testtask'
#require 'rake/rdoctask'
#require 'rdoc/task'

require 'tasks/rails'

DB2 = "messpunkte"

namespace :db2 do
  desc "Migriere die zweite Datenbank (extra für Messpunkte)"
  task :migrate => :environment do
  	ActiveRecord::Base.establish_connection(ActiveRecord::Base.configurations[DB2])
    ActiveRecord::Migration.verbose = ENV["VERBOSE"] ? ENV["VERBOSE"] == "true" : true
    ActiveRecord::Migrator.migrate("db2/migrate/", ENV["VERSION"] ? ENV["VERSION"].to_i : nil)
    Rake::Task["db2:schema:dump"].invoke if ActiveRecord::Base.schema_format == :ruby
  end

  namespace :schema do
    desc "Create a db2/schema.rb file that can be portably used against any DB supported by AR"
    task :dump => :environment do
      require 'active_record/schema_dumper'
   	  ActiveRecord::Base.establish_connection(ActiveRecord::Base.configurations[DB2])
#      File.open(ENV['SCHEMA'] || "#{RAILS_ROOT}/db2/schema.rb", "w") do |file|
      File.open("#{RAILS_ROOT}/db2/schema.rb", "w") do |file|
        ActiveRecord::SchemaDumper.dump(ActiveRecord::Base.connection, file)
      end
      Rake::Task["db2:schema:dump"].reenable
    end

    desc "Load a schema.rb file into the database"
    task :load => :environment do
  	  ActiveRecord::Base.establish_connection(ActiveRecord::Base.configurations[DB2])
#      file = ENV['SCHEMA'] || "#{RAILS_ROOT}/db2/schema.rb"
      file = "#{RAILS_ROOT}/db2/schema.rb"
      if File.exists?(file)
        load(file)
      else
        abort %{#{file} doesn't exist yet. Run "rake db2:migrate" to create it then try again. If you do not intend to use a database, you should instead alter #{RAILS_ROOT}/config/environment.rb to prevent active_record from loading: config.frameworks -= [ :active_record ]}
      end
    end
  end

end
