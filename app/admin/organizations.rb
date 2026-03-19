ActiveAdmin.register Organization do
  permit_params :name, :email, :password, :password_confirmation, :admin_user_id, :invite_user_name, :invite_user_email

  index do
    selectable_column
    id_column
    column :name
    column :email
    column :current_sign_in_at
    column :sign_in_count
    column :created_at
    actions
  end

  filter :name
  filter :email
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at

  form do |f|
    f.inputs do
      f.input :name
      f.input :email
      f.input :password
    end
     f.inputs "Invite Admin User" do
      f.input :invite_user_name
      f.input :invite_user_email
    end
    f.actions
  end


   controller do
  def create
    @organization = Organization.new(permitted_params[:organization])
    @organization.admin_user = current_admin_user

    if @organization.save
      invite_params = permitted_params[:organization]
      
      User.invite!(
        {
          email: invite_params[:invite_user_email],
          name: invite_params[:invite_user_name],
          role: "admin", 
          organization_id: @organization.id
        },
        nil
      )

      redirect_to admin_organization_path(@organization),
                  notice: "Organization created and admin invited"
    else
      render :new
    end
  end
end

end
