module SessionsHelper

  def find_user(attributes)
    User.find_by(attributes)
  end

  def build_user(attributes={})
    User.new(attributes)
  end

  def authenticate_user(user_attributes)
    user = find_user(email: user_attributes[:email])

    user = build_user if !user

    if user.password != user_attributes[:password] || user.password.nil?
      user.errors.add(:credentials, "are invalid. We don't have any users with that email/password combination")
    end

    user
  end
end
