class Person < ApplicationRecord
	belongs_to :organization, optional:true
	validates_presence_of :name, :visibility_id, :user_id, :team_id
	belongs_to :team, optional:true
	has_many :deals
	has_many :emails
	has_many :phones
	has_many :activities
	accepts_nested_attributes_for :emails, :reject_if => :all_blank, :allow_destroy => true
	accepts_nested_attributes_for :phones, :reject_if => :all_blank, :allow_destroy => true


def self.to_csv
  CSV.generate do |csv|
    csv << ["Name", "Organization_name", "Primary_email", "Primary_phone", "Added_by"]
    all.each do |person|
      csv << [ person.name, (person.organization.name if person.organization), (person.emails.first.value if person.emails.count > 0 ),  (person.phones.first.number if person.phones.count > 0 ) , User.find(person.user_id).email ]
    end
  end
end



end
