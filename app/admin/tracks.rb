ActiveAdmin.register Track do
  index do
    column :id
    column :name
    column :icon
    column :order
    default_actions
  end

  form :html => { :enctype => "multipart/form-data" } do |f|
   f.inputs "Track Details" do
     f.inputs :name
     f.inputs :icon
     f.inputs :order
    end
  f.actions
 end

end