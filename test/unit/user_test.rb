require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end

  test "user without password cannot be saved" do
    u = User.new( :email => 'onetwothree@four.com' )
    assert !u.save, 'Saved a user without a password'
  end
end
