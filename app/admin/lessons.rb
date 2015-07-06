ActiveAdmin.register Lesson do
  index do
    column :id
    column :lesson_type
    column :track_id
    column :video
    column :body
    column :icon
    column :description
    default_actions
  end

  form :html => { :enctype => "multipart/form-data" } do |f|
   f.inputs "Lesson Details" do
     f.inputs :lesson_type
     f.inputs :track_id
     f.inputs :video
     f.inputs :video_uid
     f.inputs :video_title
     f.inputs :video_author
     f.inputs :body
     f.inputs :description
     f.inputs :discussion
    end
  f.actions
 end

end
