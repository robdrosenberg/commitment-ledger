class Person < ApplicationRecord
  belongs_to :user
  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png", :default_style => :medium
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/
  has_many :commitment_people
  has_many :commitments, through: :commitment_people
  
  def as_json
    {
      id: id,
      first_name: first_name,
      last_name: last_name,
      phone_number: phone_number,
      email: email,
      description: description,
      avatar: avatar,
      brownies: brownies,
      user_id: user_id
    }    
  end  


end
