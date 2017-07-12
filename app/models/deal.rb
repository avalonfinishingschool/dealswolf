class Deal <  ApplicationRecord
  belongs_to :team
  belongs_to :stage
  belongs_to :person
  belongs_to :organization
  belongs_to :currency
  validates_presence_of :title, :value, :start_date, :stage_id, :visibility_id, :team_id, :user_id
  validates_datetime :start_date
  validates_datetime :close_date, :unless => 'close_date.blank?', :on_or_after => :start_date
  validates :value, numericality: { only_integer: true, :greater_than => -1, :less_than_or_equal_to => 10000000}
  validates :status, inclusion: { in: %w(Won Lost Pending) , message: "Not a valid status" }


def self.to_csv
  CSV.generate do |csv|
    csv << ["Title", "Contact_person", "Organization", "Email", "Phone", "Value", "Start_date", "Close_date", "Status", "Stage", "Deal Started By"]
    all.each do |deal|
      csv << [ deal.title, (deal.person.name if deal.person), (deal.organization.name if deal.organization), deal.email, deal.phone, deal.value, deal.start_date, deal.close_date, deal.status, deal.stage.name, User.find(deal.user_id).email]
    end
  end
end



end
