Factory.sequence :email do |n|
  "email_number_#{n}@middleearth.me"
end

Factory.define :gandalf, :class => User, :default_strategy => :create do |owner|
  owner.first_name 'Gandalf'
  owner.association :account
  owner.email 'gandalf@middleearth.me'
  owner.password 'test'
  owner.password_confirmation 'test'
  owner.after_create { |owner| owner.account.team_members << [owner, Factory.create(:aragorn), Factory.create(:legolas),
                                                              Factory.create(:gimli), Factory.create(:golum), Factory.create(:eagle)] }
  owner.after_create { |owner| owner.account.projects << Factory.create(:good_project, :account_id => owner.account.id, :manager_id => owner.id) }
  owner.after_create { |owner| owner.account.projects << Factory.create(:side_good_project, :account_id => owner.account.id, :manager_id => owner.id) }
end

Factory.define :sauron, :class => User, :default_strategy => :create do |owner|
  owner.first_name 'Sauron'
  owner.association :account
  owner.email 'sauron@middleearth.me'
  owner.password 'test'
  owner.password_confirmation 'test'
  owner.after_create { |owner| owner.account.team_members << [owner, Factory.create(:black_rider), User.find_by_email('golum@middleearth.me')] }
  owner.after_create { |owner| owner.account.projects << Factory.create(:bad_project, :account_id => owner.account.id, :manager_id => owner.id) }
  owner.after_create { |owner| owner.account.projects << Factory.create(:side_bad_project, :account_id => owner.account.id, :manager_id => owner.id) }
end

Factory.define :aragorn, :class => User do |dev|
  dev.first_name 'Aragorn'
  dev.email 'aragorn@middleearth.me'
  dev.password 'test'
  dev.password_confirmation 'test'
end

Factory.define :legolas, :class => User do |dev|
  dev.first_name 'Legolas'
  dev.email 'legolas@middleearth.me'
  dev.password 'test'
  dev.password_confirmation 'test'
end

Factory.define :gimli, :class => User do |dev|
  dev.first_name 'Gimli'
  dev.email 'gimli@middleearth.me'
  dev.password 'test'
  dev.password_confirmation 'test'
end

Factory.define :eagle, :class => User do |dev|
  dev.first_name 'Eagle'
  dev.email 'eagle@middleearth.me'
  dev.password 'test'
  dev.password_confirmation 'test'
end

Factory.define :black_rider, :class => User do |dev|
  dev.first_name 'Black Rider'
  dev.email 'rider@middleearth.me'
  dev.password 'test'
  dev.password_confirmation 'test'
end

Factory.define :golum, :class => User do |dev|
  dev.first_name 'Golum'
  dev.email 'golum@middleearth.me'
  dev.password 'test'
  dev.password_confirmation 'test'
end
