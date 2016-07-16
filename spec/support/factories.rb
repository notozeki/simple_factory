# Original is https://github.com/thoughtbot/factory_girl/blob/e84bfeba9b9859ebf0884c0c47f84dd7ded381e1/features/support/factories.rb

require 'active_record'

ActiveRecord::Base.establish_connection(
  :adapter  => 'sqlite3',
  :database => File.join(File.dirname(__FILE__), 'test.db')
)

class CreateSchema < ActiveRecord::Migration
  def self.up
    create_table :categories, :force => true do |t|
      t.string :name

      t.timestamps
    end
  end
end

CreateSchema.suppress_messages { CreateSchema.migrate(:up) }

class Category < ActiveRecord::Base; end
