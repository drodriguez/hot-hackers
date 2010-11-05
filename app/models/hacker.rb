class Hacker < ActiveRecord::Base
  attr_accessible :username

  before_validation :canonalize_username

  validates :username, :presence => true,
                       :uniqueness => true

  validate :username_is_github_user, :on => :create

  protected

  def canonalize_username
    self.username = self.username.downcase.strip
  end

  GITHUB_BASE_URL = 'http://github.com/api/v2/yaml/user/show/'

  def username_is_github_user
    res = HTTParty.get(GITHUB_BASE_URL + self.username) rescue nil

    if res && res.code == 200
      hacker_data = res['user']
      self.gravatar_id = hacker_data['gravatar_id']
    else
      errors.add(:username, :invalid)
    end
  end
end
