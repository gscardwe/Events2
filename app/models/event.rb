class Event < ActiveRecord::Base
  
  acts_as_mappable :lat_column_name => :latitude,
                   :lng_column_name => :longitude,
                   :auto_geocode => {:field => :street && :city && :state && :zip}
                  
  
  attr_accessible :name, :description, :street, :city, :state, :zip
  
  
  belongs_to :user
  
  validates :name, :presence => true, :length => {:maximum => 40}
  validates :description, :presence => true, :length => {:maximum => 140}
  validates :street, :presence => true
  validates :city, :presence => true
  validates :state, :presence => true
  validates :zip, :presence => true
  


  
  has_many :reverse_relationships, :foreign_key => "followed_id",
                                   :class_name  => "Relationship",
                                   :dependent   => :destroy
  has_many :followers, :through => :reverse_relationships, :source => :follower
  
  default_scope :order => 'events.created_at DESC'
  
  private
  
end

