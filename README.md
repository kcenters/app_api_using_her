app_api_using_her
=================

UI APP coumminicating with a Grape API mounted In rails using Her.


First I created the API using the tutorial from this repository: 
https://github.com/chitsaou/oauth2-api-sample

From there, I followed the steps given by this link: 
http://blog.yorkxin.org/posts/2013/11/05/oauth2-tutorial-grape-api-doorkeeper-en

The tutorial is pretty straight forward. Only problem I ran into was on step 3.2 when getting back the access token. In postman, you'll also need to add the parameter client_secret and paste in your secret token given by oauth. That is if you decide to go through the tutorial. If not, you can just pull down the repository and begin authenticating. 

Inside the API, I created the group model, group controller, and group views. The group model only contains a string field name. Simply create a migration file and add whatever fields you need. After you run a rake db:migrate you should be ready to add in groups to the api. Go to 
proof_of_concept_oauth_api_doorkeeper/app/api/v1/ and add a file called groups_api.rb. I added in this code: 

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

