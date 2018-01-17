class SignupKey
  include Mongoid::Document

  before_save :redeem_key

  KEY_TYPES = { :single => 1, :multiple => 2 }

  field :key, type: String
  field :isvalid, type: Boolean, default: false
  field :active, type: Boolean, default: true
  field :key_type, type: Integer, default: 1
  field :redeemed, type: Integer, default: 0

  validates :key, presence: true
  validates_uniqueness_of :key, :case_sensetive => false

  #validates_inclusion_of :key_type, in: [:single, :multiple]

  def validate_key?
    if self.isvalid?
      if self.key_type == KEY_TYPES[:single]
        puts 'validate 1'
        if self.redeemed == 0
          puts 'validate 2'
          return true
        else
          #key is already redeemed and invalid
          puts 'validate 3'
          return false
        end
      elsif self.key_type == KEY_TYPES[:multiple]
        return true
      end
    else
        return false
    end
  end

  def make_valid!
    self.isvalid = true
  end

  protected
  def redeem_key
    if redeemed.nil?
      self.redeemed = 1
    end

    if self.key_type == KEY_TYPES[:single] and self.active == true
      self.active = false
      self.isvalid = false
    end

    self.redeemed += 1
  end
end
