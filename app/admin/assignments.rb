ActiveAdmin.register Assignment do
  index do
    column :id
    column :course
    column :title
    column :description
    column :category
    column :req_online
    column :req_boarding
    column :require_upload

    default_actions
  end

  form :html => { :enctype => "multipart/form-data" } do |f|
   f.inputs "Assignment Details" do
     f.inputs :course
     f.inputs :title
     f.inputs :req_online, as: :select, collection: ['required', 'optional']
     f.inputs :req_boarding
     f.inputs :question_text
     f.inputs :question_duh_response
     f.inputs :business
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
  f.actions
 end

end
