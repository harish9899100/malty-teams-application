ActiveAdmin.register Team do
  permit_params :name, :organization_id

  form do |f|
    f.inputs do
      f.input :name
      f.input :organization, as: :select, collection: Organization.all
    end
    f.actions
  end
end