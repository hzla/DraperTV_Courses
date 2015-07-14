ActiveAdmin.register Topic do
  index do
    column :id
    column :name
    column :icon
    column :percent_complete
    default_actions
  end

  form :html => { :enctype => "multipart/form-data" } do |f|
   f.inputs "Topic Details" do
     f.inputs :name
     f.inputs :icon
     f.inputs :percent_complete
    end
  f.actions
 end

end