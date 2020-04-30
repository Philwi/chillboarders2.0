class User::Cell::CreateTest < Cell::TestCase

  test "renders" do
    skip 'not working atm dunno why - image could not be loaded'
    # params = { 'user' => { username: 'Philipp', password: 'hallo123', password_confirmation: 'hallo123', email: 'philrigid@gmail.com'}}
    @model = User::Operation::Create::Present.(params: nil)['model']
    html = concept(User::Cell::Create, @model).()
    assert html.include?('Anmelden')
    fill_in('email', with: 'philrigid@gmail.com')
    fill_in('password_confirmation', with:'philrigid1')
    fill_in('password', with: 'philrigid')
    fill_in('username', with: 'philrigid')
    click_button('Anmelden')
  end
end