class Phone < ApplicationRecord
	belongs_to :person, optional:true
	validates_presence_of :number
end
