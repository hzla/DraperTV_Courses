ActiveAdmin.register Resource do
  index do
    column :title
    column :description
    column :category
    default_actions
  end

  form :html => { :enctype => "multipart/form-data" } do |f|
   f.inputs "Course Details" do
     f.inputs :title
     f.inputs :description
     f.inputs :category
     f.inputs :url
     f.inputs :image,
      :styles => { :large => "250x200#" },
      :bucket => 'duhonline',
      :storage => :s3,
      :s3_credentials => "#{Rails.root}/config/s3.yml"
    end
  f.actions
 end
end
