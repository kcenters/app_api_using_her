module V1
  class GroupsAPI < Base
    namespace "groups"

    #guard_all!

    get "" do
      Group.all
    end

    get "group_users" do 
      groups = Group.includes(:users)
       groupslist = groups.map do |g|
         { :id => g.id, :name => g.name, :contacts => g.users }
       end
    end

    get ":id" do
      Group.find(params[:id])
    end

     put ":id" do 
      group = Group.find(params[:id])
      if params[:group].name.present? 
        group.name = "#{params[:group].name}"
      end
      group.save
      group
     end

     post "" do
      group = Group.new
      if params[:group].name.present? 
        group.name = "#{params[:group].name}"
      end
      group.save
      group
     end 
  end
end
