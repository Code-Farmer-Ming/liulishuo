module Auth
  extend ActiveSupport::Concern

  included do
    attr_reader :password, :current_password
    attr_accessor :password_confirmation
    validates_presence_of     :password, :if => :password_required?
    validates_confirmation_of :password, :if => :password_required?
  end
    
  def password=(new_password)
    @password = new_password
    if @password.present?
      self.create_new_salt
      self.encrypted_password =User.password_digest(@password,self.salt)
    end
  end


  def valid_password?(password)
    return false if encrypted_password.blank?
    User.secure_compare(User.password_digest(password,salt), encrypted_password)
  end
    

    
  def clean_up_passwords
    self.password = self.password_confirmation = nil
  end

  def update_without_password(params, *options)
    params.delete(:password)
    params.delete(:password_confirmation)

    result = update_attributes(params, *options)
    clean_up_passwords
    result
  end
    
  protected
    
    
  def create_new_salt  
    self.salt=Digest::MD5::hexdigest(self.object_id.to_s+rand.to_s)
  end  

    
  def password_required?
    !persisted? || !password.blank? || !password_confirmation.blank?
  end
    
  module ClassMethods
    def login?(user)
      name =user[:name]

      password = user[:password]
      if ( result = (User.where('users.name=? ',name).first))
        if result.valid_password? password
          {success: result}
        else
          {failed: 'password_incorrect'}
        end
      else
        {failed: 'user_not_exist'}
      end
    end
      
    def secure_compare(a, b)
      return false if a.blank? || b.blank? || a.bytesize != b.bytesize
      l = a.unpack "C#{a.bytesize}"

      res = 0
      b.each_byte { |byte| res |= byte ^ l.shift }
      res == 0
    end
    # Digests the password using bcrypt.
    def password_digest(password,salt)
      Digest::MD5::hexdigest("#{password}#{salt}")
    end
  end
    
  
end
 