require 'spec_helper'
require Rails.root.join('features', 'support', 'seed_data')

describe ProjectsController do
  before(:all) do
    @gandalf = Factory(:gandalf)
    @sauron = Factory(:sauron)
  end

  it "redirects to login page" do
    get :index
    response.should redirect_to(login_path)
  end

  it "redirects to login page" do
    post :index
    response.should redirect_to(login_path)
  end

  it "redirects to login page" do
    get :new
    response.should redirect_to(login_path)
  end

=begin
  it "redirects to login page" do
    get :assign
    response.should redirect_to(login_path)
  end

  it "redirects to login page" do
    post :assign
    response.should redirect_to(login_path)
  end
=end

end
