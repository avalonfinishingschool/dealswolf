class Team < ApplicationRecord
  validates_presence_of :name, :plan_id
  has_and_belongs_to_many :users, :join_table => :users_teams
  belongs_to :creator, class_name: "User", foreign_key: :user_id, optional:true
  extend FriendlyId
  friendly_id :name, use: :slugged
  belongs_to :plan, optional:true
  has_many :deals, :dependent => :destroy
  has_many :activities, :dependent => :destroy
  has_many :stages, :dependent => :destroy
  accepts_nested_attributes_for :stages, :reject_if => :all_blank, :allow_destroy => true
  has_many :people, :dependent => :destroy
  has_many :organizations, :dependent => :destroy
  
end
