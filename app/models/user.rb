class User < ActiveRecord::Base

  acts_as_authentic

  #acts_as_authentic do |c|
  #  c.login_field = :email
  #end

  has_many :stories, :foreign_key => 'developer_id'
  has_many :responsibilities, :class_name => 'Story', :foreign_key => 'responson'
  has_one :account

  has_and_belongs_to_many :projects, :foreign_key => 'developer_id', :join_table => 'projects_developers'

  def developer?
    projects.size > 0
  end

  def owner?
    !account.nil?
  end
end
