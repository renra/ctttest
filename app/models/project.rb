class Project < ActiveRecord::Base
  validates_presence_of :title, :description, :manager_id, :account_id

  belongs_to :account
  belongs_to :manager, :class_name => 'User'
  has_many :stories
  has_and_belongs_to_many :developers, :class_name => 'User', :association_foreign_key => 'developer_id', :join_table => 'projects_developers'
  #, :class_name => 'User', :foreign_key => 'developer_id'
end
