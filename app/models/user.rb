class User < ActiveRecord::Base
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
