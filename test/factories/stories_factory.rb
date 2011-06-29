Factory.define :not_ready, :class => Story do |s|
  s.title 'Frodo meets Gandalf'
  s.description 'Frodo learns the truth about the Bilbo\'s ring'
  s.scale_level_id { |sl_id| sl_id = ScaleLevel.find_by_level(100) }
  s.life_cycle_phase_id { |lc_id| lf_id = LifeCyclePhase.find_by_phase('not ready').id }
end

Factory.define :waiting, :class => Story do |s|
  s.title 'Frodo and his company meet Aragorn'
  s.description '... at the Prancing Pony'
  s.scale_level_id { |sl_id| sl_id = ScaleLevel.find_by_level(100) }
  s.life_cycle_phase_id { |lc_id| lf_id = LifeCyclePhase.find_by_phase('waiting').id }
end

Factory.define :started, :class => Story do |s|
  s.title 'Journey to Rivendell'
  s.description 'Frodo and the company travel to Rivendell'
  s.scale_level_id { |sl_id| sl_id = ScaleLevel.find_by_level(100) }
  s.life_cycle_phase_id { |lc_id| lf_id = LifeCyclePhase.find_by_phase('started').id }
end

Factory.define :finished, :class => Story do |s|
  s.title 'Forging of the Fellowship'
  s.description 'The council in Rivendell decides to destroy the Ring. Boromir does not like it'
  s.scale_level_id { |sl_id| sl_id = ScaleLevel.find_by_level(100) }
  s.life_cycle_phase_id { |lc_id| lf_id = LifeCyclePhase.find_by_phase('finished').id }
end

Factory.define :delivered, :class => Story do |s|
  s.title 'Fall of Gandalf'
  s.description 'Gandalf is pulled into an abyss by a fiery demon'
  s.scale_level_id { |sl_id| sl_id = ScaleLevel.find_by_level(100) }
  s.life_cycle_phase_id { |lc_id| lf_id = LifeCyclePhase.find_by_phase('delivered').id }
end

Factory.define :rejected, :class => Story do |s|
  s.title 'The Fellowship holds on'
  s.description 'They go through many a hardship'
  s.scale_level_id { |sl_id| sl_id = ScaleLevel.find_by_level(100) }
  s.life_cycle_phase_id { |lc_id| lf_id = LifeCyclePhase.find_by_phase('rejected').id }
end

Factory.define :accepted, :class => Story do |s|
  s.title 'The ring gets destroyed in the end'
  s.description 'And Gandalf did not die after all'
  s.scale_level_id { |sl_id| sl_id = ScaleLevel.find_by_level(100) }
  s.life_cycle_phase_id { |lc_id| lf_id = LifeCyclePhase.find_by_phase('accepted').id }
end

Factory.define :eagle_story, :class => Story do |s|
  s.title 'Rescue of Frodo and Sam'
  s.description 'I saved them from the Mountain of Doom'
  s.scale_level_id { |sl_id| sl_id = ScaleLevel.find_by_level(100) }
  s.life_cycle_phase_id { |lc_id| lf_id = LifeCyclePhase.find_by_phase('accepted').id }
end
