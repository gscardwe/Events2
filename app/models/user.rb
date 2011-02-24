class User < ActiveRecord::Base
  acts_as_authentic
  
  has_many :events, :dependent => :destroy
  has_many :relationships, :foreign_key => "follower_id",
                           :dependent => :destroy
                           
  has_many :following, :through => :relationships, :source => :followed

  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  validates :username,  :presence   => true,
                        :length     => { :maximum => 20 }
                        :uniqueness 
  validates :email, :presence   => true,
                    :format     => { :with => email_regex },
                    :uniqueness => { :case_sensitive => false }
  # Automatically create the virtual attribute 'password_confirmation'.
  validates :password, :presence     => true,
                       :confirmation => true,
                       :length       => { :within => 4..40}

  
  def following?(followed)
    relationships.find_by_followed_id(followed)
  end 
  
  def follow!(followed)
    relationships.create!(:followed_id => followed.id)
  end
  
  def unfollow!(followed)
    relationships.find_by_followed_id(followed).destroy
  end

  
end
