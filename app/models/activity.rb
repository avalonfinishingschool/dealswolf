class Activity < ApplicationRecord
	belongs_to :team
	belongs_to :deal
	belongs_to :type
    belongs_to :person
	validates_presence_of :name, :team_id, :type_id, :date, :user_id
	validates_datetime :date
	validates :length, numericality: { only_integer: true, :greater_than => -1 }


  def self.to_csv
  CSV.generate do |csv|
    csv << ["Name", "Deal_name", "Person_name", "Organization_name", "Type", "Note", "Date", "Time(in hours)", "Reponsibility", "Status"]
    all.each do |activity|
      csv << [ activity.name, (activity.person.name if activity.person), (activity.person.organization if activity.person), (activity.type.name if activity.type),  activity.note, activity.date, activity.length, User.find(activity.user_id).email, activity.done]
  end
end
end


end
