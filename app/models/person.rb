class Person < ApplicationRecord
  belongs_to :user
  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png", :default_style => :thumb
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/
  has_many :commitment_people
  has_many :commitments, through: :commitment_people
  
  def calculate_brownies
    # complete_count = self.commitments.where(status: "Complete").count
    # broken
    total_points = 0
    self.commitments.each do |commitment|
      if commitment.status == "Complete"
        total_points += 10
      elsif commitment.status == "Broken"
        total_points -=20
      end
    end
    return total_points
  end

  def phone_format(phone)
    if phone =~ /^(\d{3})(\d{3})(\d{4})$/
      "#{$1}.#{$2}.#{$3}"
    end
  end

  def as_json
    {
      id: id,
      first_name: first_name,
      last_name: last_name,
      name: "#{first_name} #{last_name}",
      phone_number: phone_format(phone_number),
      email: email,
      description: description,
      avatar: avatar,
      brownies: calculate_brownies,
      user_id: user_id,
      commitments: commitments.map{|commitment| commitment.attributes}
    }    
  end  


end
