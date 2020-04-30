require 'test_helper'

class User::Operation::CreateTest < ActiveSupport::TestCase

  test 'create a user' do
    params = { 'user' => { username: 'Philipp', password: 'hallo123', password_confirmation: 'hallo123', email: 'philrigid@gmail.com'}}
    assert_difference 'User.count' do
      result = User::Operation::Create.(params: params)
      assert result.success?
    end
  end

  test 'dont create a user because of missing attributes' do
    params = { 'user' => { username: nil, password: 'hallo123', password_confirmation: 'hallo123', email: 'philrigid@gmail.com'}}
    assert_no_difference 'User.count' do
      result = User::Operation::Create.(params: params)
      assert result.failure?
      assert_equal result['contract.default'].errors.messages, {:username=>["muss ausgefüllt werden"]}
    end

    # passwords are not the same
    params = { 'user' => { username: 'Philipp', password: 'hallo123', password_confirmation: 'hallo1234', email: 'philrigid@gmail.com'}}
    assert_no_difference 'User.count' do
      result = User::Operation::Create.(params: params)
      assert result.failure?
      assert result['contract.default'].errors.messages.values.first.include?("Die angegebenen Passwörter stimmen nicht überein")
    end

    params = { 'user' => { username: 'Philipp', password: 'hallo123', password_confirmation: 'hallo123', email: ''}}
    assert_no_difference 'User.count' do
      result = User::Operation::Create.(params: params)
      assert result.failure?
      assert_equal result['contract.default'].errors.messages, {:email=>["muss ausgefüllt werden", "ist nicht gültig"]}
    end
  end
end
