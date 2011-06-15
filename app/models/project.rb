class Project < ActiveRecord::Base
  belongs_to :account
  # fixit
  has_and_belongs_to_many :developers, :class_name => 'User', :join_table => 'projects_developers'
  belongs_to :manager, :class_name => 'User'
end
