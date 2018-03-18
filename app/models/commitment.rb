class Commitment < ApplicationRecord
  belongs_to :user
  belongs_to :category

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
      user_id: user_id

    }
  end

  def formatted_time(time)
    if time
      time.strftime("%m/%e/%Y, %l:%M %p")
    end
  end

end
