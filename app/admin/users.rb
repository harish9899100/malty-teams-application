ActiveAdmin.register User do
  permit_params :name, :email, :password, :password_confirmation,
                :role, :organization_id, :team_id, :invited_by_id
  index do
    selectable_column
    id_column
    column :name
    column :email
    column :role
    column :organization
    column :team
    column :invited_by
    column :invitation_accepted_at
    column :created_at
    actions
  end
  filter :name
  filter :email
  #filter :role, as: :select, collection: User.roles.keys
  filter :organization
 # filter :team
  filter :created_at
  form do |f|
    f.inputs do
      f.input :name
      f.input :email

      f.input :password, required: false
      f.input :password_confirmation, required: false

      #f.input :role, as: :select, collection: User.roles.keys

      f.input :organization,
              as: :select,
              collection: Organization.all

      f.input :team,
              as: :select,
              collection: Team.where(organization_id: f.object.organization_id)

      f.input :invited_by,
              as: :select,
              collection: User.all
    end
    f.actions
  end
end
