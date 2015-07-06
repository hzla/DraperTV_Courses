ActiveAdmin.register Mod do
  index do
    column :id
    column :name
    column :order
    column :track_id
    default_actions
  end

  form :html => { :enctype => "multipart/form-data" } do |f|
   f.inputs "Mod Details" do
     f.inputs :name
     f.inputs :track_id
     f.inputs :order
    end
  f.actions
 end

end