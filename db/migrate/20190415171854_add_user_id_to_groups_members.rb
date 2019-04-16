class AddUserIdToGroupsMembers < ActiveRecord::Migration[5.2]
  def change
    add_reference :groups_members, :user, foreign_key: true
  end
end
