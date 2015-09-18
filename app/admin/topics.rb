ActiveAdmin.register Topic do
  index do
    column :id
    column :name
    column :icon
    column :percent_complete
    actions
  end

  form :html => { :enctype => "multipart/form-data" } do |f|
   f.inputs "Topic Details" do
     f.inputs :name
     f.inputs :icon
     f.inputs :percent_complete
     f.inputs :body
     f.inputs :order
    end
  f.actions
 end

end
