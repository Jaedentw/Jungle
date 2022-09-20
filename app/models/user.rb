class User < ApplicationRecord
  has_secure_password

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: {minimum: 8}
  validates :password_confirmation, presence: true, length: {minimum: 8}

  def authenticate_pass
    if :password == :password_confirmation
      true
    else
      false
    end
  end

  def authenticate_with_credentials(email, password)
    cased_email = email.downcase.strip
    @user = User.find_by_email(cased_email)

    if @user && @user.authenticate(password)
      @user
    end
  
  end

end
