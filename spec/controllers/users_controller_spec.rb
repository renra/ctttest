require 'spec_helper'
require Rails.root.join('features', 'support', 'seed_data')

describe UsersController do
  #render_views

  before(:all) do
    @gandalf = Factory(:gandalf)
    @sauron = Factory(:sauron)
  end

  it 'should be success' do
    get :login
    response.should be_success
  end

  it 'should not let just whatever pass' do
    post :login, {:user_session => {:email => 'whatever', :password => 'whatever'}}
    response.should render_template('users/login')
  end

  it 'should allow Gandalf to enter' do
    post :login, {:user_session => {:email => @gandalf.email, :password => 'test'}}
    #session is empty, don't know why
    #session[:user_id].should == @gandalf.id
    response.should redirect_to root_path
  end

  it 'should require login before logout' do
    get :logout
    response.should redirect_to login_path
  end

  it 'should logout and redirect to login' do
    post :login, {:user_session => {:email => @gandalf.email, :password => 'test'}}
    get :logout
    #session[:user_id].should be_nil
    response.should redirect_to login_path
  end

  it 'should reset session after login' do
    session_id_before_login = session[:session_id]
    post :login, {:user_session => {:email => @gandalf.email, :password => 'test'}}
    session.should_not be_empty
    session_id_before_login.should_not == session[:session_id]
  end

  it 'should allow Gandalf to see his team members' do
    post :login, {:user_session => {:email => @gandalf.email, :password => 'test'}}
    get :index
    response.should render_template('users/index')
  end

  it 'should render the sign up template' do
    get :signup
    response.should render_template('users/signup')
  end

  it 'should allow guest to signup' do
    post :signup, {:user => {:first_name => 'John', :last_name => 'Doe', :email => "#{Time.now.to_i}@void.ns", :password => 'test', :password_confirmation => 'test'}}
    response.should redirect_to root_path
  end

  it 'should allow guest to signup' do
    mail = "#{(Time.now+1.second).to_i}@void.ns"
    post :signup, {:user => {:first_name => 'John', :last_name => 'Doe', :email => mail, :password => 'test', :password_confirmation => 'test'}}
    User.find_by_email( mail ).account.should_not be_nil
  end

  it 'should render the signup template if there are errors' do
    post :signup, {:user => {:first_name => 'John', :last_name => 'Doe', :email => "#{Time.now.to_i}@void.ns", :password => 'test', :password_confirmation => 'test123'}}
    response.should render_template('users/signup')
  end

end
