require 'test_helper'

class User::Operation::UpdateTest < ActiveSupport::TestCase

  setup do
    params = { 'user' => { username: 'Philipp', password: 'hallo123', password_confirmation: 'hallo123', email: 'philrigid@gmail.com'}}
    @user = User::Operation::Create.(params: params)['model']
  end
  test 'update user with social media stuff' do
    params = ActionController::Parameters.new({
      "user"=>{
        "experience_level"=>"beginner", "city"=>"Dresden",
        "description"=>"i bims", "favourite_trick"=>"Lazerflip",
        "social_media"=>"", "facebook"=>"ist doof", "instagram"=>"ist cool",
        "youtube"=>"geht", "password"=>"",
        "password_confirmation"=>""
    }})

    result = User::Operation::Update.(params: params, user: @user)
    assert result.success?
    assert user = result['model']
    assert_equal 'beginner', user.experience_level
    assert_equal 'Dresden', user.city
    assert_equal 'i bims', user.description
    assert_equal 'Lazerflip', user.favourite_trick
    assert_equal 'ist doof', user.facebook
    assert_equal 'ist cool', user.instagram
    assert_equal 'geht', user.youtube
  end
end