class User < ApplicationRecord
  has_secure_password
  has_many :commitments
  has_many :people
  attr_reader :avatar_remote_url
  has_attached_file :avatar, styles: { medium: "300x300#", thumb: "100x100>" }, default_url: "/images/:style/missing.png", :default_style => :medium
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/
  validates_attachment_file_name :avatar, matches: [/png\z/, /jpe?g\z/, /gif\z/]
  validates :email, presence: true, uniqueness: true
  validates :user_name, presence: true, uniqueness: true
  def avatar_remote_url=(url_value)
    self.avatar = URI.parse(url_value)
    # Assuming url_value is http://example.com/photos/face.png
    # avatar_file_name == "face.png"
    # avatar_content_type == "image/png"
    @avatar_remote_url = url_value
  end

  def as_json
    {
      id: id,
      first_name: first_name,
      last_name: last_name,
      user_name: user_name,
      email: email,
      bio: bio,
      profile_picture: profile_picture,
      avatar: avatar
    }
  end

end
