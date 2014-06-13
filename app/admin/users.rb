ActiveAdmin.register User do
  index do
    column :id
    column :first_name
    column :last_name
    column :role
    column :team
    column :last_sign_in_at
    column :email
    default_actions
  end

  form do |f|
   f.inputs "User Details" do
     f.inputs :first_name
     f.inputs :last_name
     f.inputs :email
     f.inputs :tag_list
     f.inputs :team
     f.inputs :bio
     f.inputs :skype
     f.inputs :gmail
     f.inputs :twitter
     f.inputs :facebook
     f.inputs :linkedin
     f.inputs :instagram
     f.inputs :angellist
     f.inputs :dribbble
     f.inputs :github
     f.inputs :program
     f.inputs :online
     f.inputs :street_address
     f.inputs :city
     f.inputs :state
     f.inputs :zip
     f.inputs :country
     f.inputs :eventReminder
     f.inputs :password
     f.inputs :role
     f.inputs :avatar,
      :styles => { :medium => "120x120#", :thumb => "40x40#" },
      :bucket => 'duhonline',
      :storage => :s3,
      :s3_credentials => "#{Rails.root}/config/s3.yml"
   end
  f.actions
 end

end
