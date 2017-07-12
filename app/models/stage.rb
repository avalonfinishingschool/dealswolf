class Stage < ApplicationRecord
	belongs_to :team, optional:true
	has_many :deals
	validates_presence_of  :name
end
