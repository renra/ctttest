Factory.define :good_project, :class => Project do |p|
  p.title 'Save Middle Earth'
  p.description 'Sauron\'s fingers are becoming too long'
  p.client 'Middle Earth'
  p.deadline Time.now+1.year
  p.after_create {|p| p.developers << User.where(:email => ['gandalf@middleearth.me', 'aragorn@middleearth.me', 'eagle@middleearth.me',
                                                            'legolas@middleearth.me', 'gimli@middleearth.me', 'golum@middleearth.me']) }
  p.after_create {|p| p.stories << [Factory.create(:not_ready, :project_id => p.id, :requestor_id => User.find_by_email('gandalf@middleearth.me').id,
                                                  :responson_id => User.find_by_email('gandalf@middleearth.me').id),
                                    Factory.create(:waiting, :project_id => p.id, :requestor_id => User.find_by_email('aragorn@middleearth.me').id,
                                                  :responson_id => User.find_by_email('aragorn@middleearth.me').id),
                                    Factory.create(:started, :project_id => p.id, :requestor_id => User.find_by_email('gimli@middleearth.me').id,
                                                  :responson_id => User.find_by_email('legolas@middleearth.me').id),
                                    Factory.create(:finished, :project_id => p.id, :requestor_id => User.find_by_email('legolas@middleearth.me').id,
                                                  :responson_id => User.find_by_email('eagle@middleearth.me').id),
                                    Factory.create(:delivered, :project_id => p.id, :requestor_id => User.find_by_email('golum@middleearth.me').id,
                                                  :responson_id => User.find_by_email('gandalf@middleearth.me').id),
                                    Factory.create(:rejected, :project_id => p.id, :requestor_id => User.find_by_email('aragorn@middleearth.me').id,
                                                  :responson_id => User.find_by_email('legolas@middleearth.me').id),
                                    Factory.create(:accepted, :project_id => p.id, :requestor_id => User.find_by_email('gandalf@middleearth.me').id,
                                                  :responson_id => User.find_by_email('gandalf@middleearth.me').id)] }
end

Factory.define :bad_project, :class => Project do |p|
  p.title 'Rule Middle Earth'
  p.description 'They cannot stand against me'
  p.client 'Sauron'
  p.deadline Time.now+1.year
  p.after_create {|p| p.developers <<  User.where(:email => ['rider@middleearth.me', 'golum@middleearth.me']) }
end

Factory.define :side_good_project, :class => Project do |p|
  p.title 'Save Frodo and Sam'
  p.description 'Get Frodo out of Mordor in one piece'
  p.client 'Frodo'
  p.deadline Time.now+1.year
  p.after_create {|p| p.developers <<  User.where(:email => 'eagle@middleearth.me') }
  p.after_create {|p| p.stories << Factory.create(:eagle_story, :project_id => p.id, :requestor_id => User.find_by_email('eagle@middleearth.me').id,
                                                   :responson_id => User.find_by_email('eagle@middleearth.me').id)}
end

Factory.define :side_bad_project, :class => Project do |p|
  p.title 'Recruit pirates'
  p.description 'Go south, promise them gold and glory'
  p.client 'Sauron'
  p.deadline Time.now+1.year
  p.after_create {|p| p.developers <<  User.where(:email => 'rider@middleearth.me') }
end
