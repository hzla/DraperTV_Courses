ActiveAdmin.register Assignment do
  index do
    column :id
    column :course
    column :title
    column :description
    column :category
    default_actions
  end

  form :html => { :enctype => "multipart/form-data" } do |f|
   f.inputs "Assignment Details" do
     f.inputs :course
     f.inputs :title
     f.inputs :description
     f.inputs :vimeo_url
     f.inputs :survey_id
     f.inputs :require_upload
     f.inputs :speaker_name
     f.inputs :speaker_bio
     f.inputs :speaker_linkedin
     f.inputs :speaker_twitter
     f.inputs :speaker_angel
     f.inputs :category
     f.inputs :order_id
     f.inputs :speaker_pic,
      :bucket => 'duhonline',
      :storage => :s3,
      :s3_credentials => "#{Rails.root}/config/s3.yml"
   end
  f.buttons
 end

end
