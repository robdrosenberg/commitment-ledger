class Commitment < ApplicationRecord
  belongs_to :user
  belongs_to :category, optional: true

  validates :what, presence: true

  def as_json
    {
      id: id,
      who: who,
      what: what,
      due: due,
      notes: notes,
      status: status,
      category_id: category_id,
      category: category.as_json,
      user_id: user_id

    }
  end
end
