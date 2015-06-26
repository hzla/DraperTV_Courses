ActiveAdmin.register Course do
  index do
    column :id
    column :title
    column :description
    column :start_date
    column :end_date
    column :length
    default_actions
  end

  form do |f|
   f.inputs "Course Details" do
     f.inputs :title
     f.inputs :description
     f.inputs :start_date
     f.inputs :end_date
     f.inputs :intro_vimeo
     f.inputs :badge_vimeo
     f.inputs :length
     f.inputs :course_icon,
      :styles => { :medium => "120x120#", :thumb => "40x40#" },
      :bucket => 'duhonline',
      :storage => :s3,
      :s3_credentials => "#{Rails.root}/config/s3.yml"
     f.inputs :tile_image,
      :styles => { :medium => "260x320#", :thumb => "80x80#" },
      :bucket => 'duhonline',
      :storage => :s3,
      :s3_credentials => "#{Rails.root}/config/s3.yml"
     f.inputs :intro_screenshot,
      :bucket => 'duhonline',
      :storage => :s3,
      :s3_credentials => "#{Rails.root}/config/s3.yml"
    end
  f.actions
 end

end
