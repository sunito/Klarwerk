class Messpunkt < ActiveRecord::Base
  belongs_to :quelle #, :foreign_key => :pumuckl_id
end
