class CommitmentPerson < ApplicationRecord
  belongs_to :person
  belongs_to :commitment
end
