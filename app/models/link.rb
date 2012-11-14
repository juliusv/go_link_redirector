class Link < ActiveRecord::Base
  attr_accessible :short_name, :url, :comments, :owner_email
  self.per_page = 30

  RESERVED_SHORT_NAMES = %w{links signin signout auth about home contact assets public int}

  VALID_SHORT_NAME_REGEX = /\A[a-z\d\-_]+\z/i
  VALID_URL_REGEX = /\A(http|https):\/\//i
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :short_name, presence: true,
                         uniqueness: { case_sensitive: false },
                         length: { maximum: APP_CONFIG['short_name_max_length'] || 40 },
                         format: { with: VALID_SHORT_NAME_REGEX },
                         exclusion: { in: RESERVED_SHORT_NAMES,
                                      message: 'is reserved.' }
  validates :url, presence: true,
                  length: { maximum: APP_CONFIG['url_max_length'] || 500 },
                  format: { with: VALID_URL_REGEX }
  validates :comments, length: { maximum: APP_CONFIG['comments_max_length'] || 100 }
  validates :owner_email, format: { with: VALID_EMAIL_REGEX }
  validates :last_change_email, presence: true,
                                format: { with: VALID_EMAIL_REGEX }

  before_save { self.owner_email.downcase! }
  before_save { self.last_change_email.downcase! }
end
