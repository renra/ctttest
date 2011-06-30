require 'spec_helper'
require Rails.root.join('features', 'support', 'seed_data')

describe LifeCyclePhase do

  it 'should return an array with only \'not ready\' and \'waiting\'' do
    phases = LifeCyclePhase.available_phases
    phases.size.should == 2
    phases.map {|p| p.phase}.should include('not ready', 'waiting')
  end


  it 'should return an array with only \'not ready\' and \'waiting\'' do
    initial = LifeCyclePhase.find_by_phase('not ready')
    phases = LifeCyclePhase.available_phases( initial )
    phases.size.should eq( 2 )
    phases.map {|p| p.phase}.should include('not ready', 'waiting')
  end

  it 'should return an array with only \'waiting\' and \'started\'' do
    initial = LifeCyclePhase.find_by_phase('waiting')
    phases = LifeCyclePhase.available_phases( initial )
    phases.size.should eq( 2 )
    phases.map {|p| p.phase}.should include('waiting', 'started')
  end

  it 'should return an array with only \'started\' and \'finished\'' do
    initial = LifeCyclePhase.find_by_phase('started')
    phases = LifeCyclePhase.available_phases( initial )
    phases.size.should eq( 2 )
    phases.map {|p| p.phase}.should include('started', 'finished')
  end

  it 'should return an array with only \'finished\' and \'delivered\'' do
    initial = LifeCyclePhase.find_by_phase('finished')
    phases = LifeCyclePhase.available_phases( initial )
    phases.size.should eq( 2 )
    phases.map {|p| p.phase}.should include('finished', 'delivered')
  end

  it 'should return an array with only \'delivered\', \'accepted\' and \'rejected\'' do
    initial = LifeCyclePhase.find_by_phase('delivered')
    phases = LifeCyclePhase.available_phases( initial )
    phases.size.should eq( 3 )
    phases.map {|p| p.phase}.should include('delivered', 'accepted', 'rejected')
  end

  it 'should return an array with only \'rejected\' and \'started\'' do
    initial = LifeCyclePhase.find_by_phase('rejected')
    phases = LifeCyclePhase.available_phases( initial )
    phases.size.should eq( 2 )
    phases.map {|p| p.phase}.should include('rejected', 'started')
  end

  it 'should return an array with only \'accepted\'' do
    initial = LifeCyclePhase.find_by_phase('accepted')
    phases = LifeCyclePhase.available_phases( initial )
    phases.size.should eq( 1 )
    phases.map {|p| p.phase}.should include('accepted')
  end

end
