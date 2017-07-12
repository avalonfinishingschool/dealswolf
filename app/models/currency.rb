class Currency <  ApplicationRecord
	validates :country, :presence => true
	validates :extension, :presence => true
	validates :country, :uniqueness => true
end
