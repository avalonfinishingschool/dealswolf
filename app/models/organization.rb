class Organization < ApplicationRecord
	has_many :people
	validates_presence_of :name, :visibility_id, :user_id, :team_id
	belongs_to :team, optional:true
  validates_format_of :phone, :with => /\d[0-9]\)*\z/, :message => "Only positive number without spaces are allowed"

def self.to_csv
  CSV.generate do |csv|
    csv << ["Name", "Address", "Phone", "Added_by"]
    all.each do |organization|
      csv << [ organization.name, organization.address, organization.phone, User.find(organization.user_id).email ]
    end
  end
end




end
