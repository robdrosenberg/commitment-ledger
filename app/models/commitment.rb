class Commitment < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :commitment_people
  has_many :people, through: :commitment_people

  validates :what, presence: true

  def as_json
    {
      id: id,
      who: who,
      what: what,
      due: formatted_time(due),
      notes: notes,
      status: status,
      category_id: category_id,
      category: category.as_json,
      user_id: user_id,
      people: people.as_json

    }
  end

  def formatted_time(time)
    if time
      time.strftime("%m/%e/%Y, %l:%M %p")
    end
  end

end
