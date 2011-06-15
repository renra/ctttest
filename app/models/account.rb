class Account < ActiveRecord::Base
  belongs_to :owner, :class_name => 'User'
  has_many :projects
  # ?has_many :developers? - all the developers of all the account's projects, no, can be solved using multiple include
end
