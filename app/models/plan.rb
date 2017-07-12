class Plan < ApplicationRecord
	validates :name, :presence => true
	validates :name, :uniqueness => true
	validates :number_users, :presence => true
	validates :duration, :presence => true
	has_many :teams
	validates :price, :presence => true
	validates :number_users, :duration, numericality: { only_integer: true, :greater_than => -1 }
	validates :price, numericality: { :greater_than => -1 }
end
