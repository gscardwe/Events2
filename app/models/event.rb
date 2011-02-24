class Event < ActiveRecord::Base
  attr_accessible :name, :description
  
  belongs_to :user
  
  validates :name, :presence => true, :length => {:maximum => 40}
  validates :description, :presence => true, :length => {:maximum => 140}
  
  has_many :reverse_relationships, :foreign_key => "followed_id",
                                   :class_name  => "Relationship",
                                   :dependent   => :destroy
  has_many :followers, :through => :reverse_relationships, :source => :follower
  
  default_scope :order => 'events.created_at DESC'
end
