# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

development_phases = LifeCyclePhase.create([{:phase => 'not ready'},
                                            {:phase => 'waiting'},
                                            {:phase => 'started'},
                                            {:phase => 'finished'},
                                            {:phase => 'delivered'},
                                            {:phase => 'accepted'}, 
                                            {:phase => 'rejected'}])

scale_levels = ScaleLevel.create([{:level => 1},
				  {:level => 2},
				  {:level => 3},
				  {:level => 5},
  				  {:level => 8},
				  {:level => 10},
				  {:level => 20},
				  {:level => 35}, 
 				  {:level => 50},
				  {:level => 75},
				  {:level => 90},
				  {:level => 99},
				  {:level => 100}])
