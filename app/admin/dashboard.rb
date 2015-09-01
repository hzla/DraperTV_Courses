ActiveAdmin.register_page "Dashboard" do

  menu :priority => 1, :label => proc{ I18n.t("active_admin.dashboard") }

  content :title => proc{ I18n.t("active_admin.dashboard") } do
    columns do
        column do
            panel "Students" do
                table_for User.all do
                    column :id
                    column :first_name
                    column :last_name
                    column :last_sign_in_at
                end
            end
        end
    end
  end
end
