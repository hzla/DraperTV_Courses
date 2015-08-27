ActiveAdmin.register Event do
  index do
    column :id
    column :name
    column :start_time
    default_actions
  end

  form do |f|
   f.inputs "Topic Details" do
     f.inputs :name
     f.inputs :start_time
    end
  f.actions
 end

end
