require 'spec_helper'
require Rails.root.join('features', 'support', 'seed_data')

describe UsersController do
  before(:all) do
    @gandalf = Factory(:gandalf)
    @sauron = Factory(:sauron)
  end

  

end
