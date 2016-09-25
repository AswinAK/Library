class Admin < ActiveRecord::Base
  has_secure_password
  validates :name, :presence => {:message => "Please enter a name"}
  validates :email_id, :presence => {:message => "Please enter a name"}
end
