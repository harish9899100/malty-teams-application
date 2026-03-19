class AddAdminUserToOrganizations < ActiveRecord::Migration[7.1]
  def change
    add_reference :organizations, :admin_user, null: false, foreign_key: true
  end
end
