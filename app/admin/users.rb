ActiveAdmin.register User do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end

  action_item :sugee_action, only: :show do
    link_to "sugeeee", {action: :sugee}, method: :put
  end

  member_action :sugee, method: :put do
    resource.name = "sugee"
    resource.save!
    redirect_to resource_path, notice: "sugee!"
  end
end
