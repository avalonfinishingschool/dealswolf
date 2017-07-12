class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :email, :presence => true

    def self.search(search)
      if search
        where('lower(email) = ?', "#{search}").first
      end
    end

    def self.generate_random_password(size = 8)
      charset = %w{ 2 3 4 6 7 9 A C D E F G H J K M N P Q R T V W X Y Z}
      (0...size).map{ charset.to_a[rand(charset.size)] }.join
    end

has_and_belongs_to_many :teams, :join_table => :users_teams
has_one :owned_team, class_name: "Team", foreign_key: :user_id, :dependent => :destroy
end
