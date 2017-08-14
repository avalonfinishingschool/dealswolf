class Email <  ApplicationRecord
	belongs_to :person
	validates_presence_of :value
  validates_format_of :value, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
end
