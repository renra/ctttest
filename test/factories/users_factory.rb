Factory.sequence :email do |n|
  "email_number_#{n}@tao.ci"
end

Factory.define :account_owner_honza do |owner|
  owner.first_name 'Honza'
  owner.last_name 'Gloser'
  owner.email Factory.next(:email)
  owner.password 'test'
  owner.password_confirmation 'test'
end

Factory.define :account_owner_zbynek do |owner|
  owner.first_name 'Zbynek'
  owner.last_name 'Resolg'
  owner.email Factory.next(:email)
  owner.password 'test'
  owner.password_confirmation 'test'
end

Factory.define :developer do |dev|
  dev.first_name 'Vasek'
  dev.last_name 'Stasek'
  dev.email Factory.next(:email)
  dev.password 'test'
  dev.password_confirmation 'test'
end
