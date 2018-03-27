class AddAttachmentAvatarToPeople < ActiveRecord::Migration[5.1]
  def change
    add_attachment :people, :avatar
  end
end
