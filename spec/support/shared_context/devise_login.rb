# frozen_string_literal: true

RSpec.shared_context :devise_login do
  let(:user) { passed_in_user }
  before do
    post user_session_path, params: { user: { email: passed_in_user.email,
                                              password: passed_in_user.password } }
    follow_redirect!
  end

  # working
  # let(:user) { create(:user) }
  # before { devise_login_as user }
  # Login through devise
  # def devise_login_as(user)
  #   post user_session_path, params:
  #     { user:
  #          { email: user.email,
  #            password: user.password } }
  #   follow_redirect!
  # end
end
