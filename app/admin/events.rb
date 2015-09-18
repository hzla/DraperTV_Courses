ActiveAdmin.register Event do
  index do
    column :id
    column :name
    column :start_time
    actions
  end

  form do |f|
   f.inputs "Topic Details" do
     f.inputs :name
     f.inputs :start_time
     f.inputs :color
     f.inputs :url
    end
  f.actions
 end

end
