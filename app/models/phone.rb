class Phone < ApplicationRecord
	belongs_to :person, optional:true
	validates_presence_of :number
  validates_format_of :number, :with => /\d[0-9]\)*\z/, :message => "Only positive number without spaces are allowed"
end
