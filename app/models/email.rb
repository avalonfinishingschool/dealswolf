class Email <  ApplicationRecord
	belongs_to :person
	validates_presence_of :value
end
