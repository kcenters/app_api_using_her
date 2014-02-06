app_api_using_her
=================

UI APP coumminicating with a Grape API mounted In rails using Her.



API
=================
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


The get "" method allows the user from the app to retrieve all groups. 
The get ":id" method allows the user to retrieve a specific group. 
The put ":id" method allows the user in the app to edit and change fields 
The post "" allows the user in the app to create a new group 

As it stands right now, the API is unprotected. If you want to secure the api simply uncomment the guard_all method. 


APP
=================
Navigate out of the proof_of_concept_oauth_api_doorkeeper to the app directory. 

For the app side of things, you just simply create a new app. Once you set up your authorization. In order to communicate with the API I used the gem called her. Add this line to your gemfile: 

gem "her"


Next in config/initializers create a file called her.rb and paste in this code: 

# Configure Her
Her::API.setup :url => "http://localhost:3001/api/v1" do |c|
  c.use Faraday::Request::UrlEncoded
  c.use Her::Middleware::DefaultParseJSON
  c.use Faraday::Response::Logger, $logger
  c.use Faraday::Adapter::NetHttp
end


As you can see the API.setup url will point to the api project running on port 3001.

Now in your app/models directory create a file called Group.rb and place this code inside

 class Group 
 	include Her::Model

  	# Parsing options
  	parse_root_in_json true
  	include_root_in_json true
  	
 	# Attributes
  	attributes :id, :name
 end
 
This tells us that the Group model will be using the API's Group model. The attributes at the end of the code tells us which attributes we are going to bring back to display to the user on the front end. 

After that,  in the app/controllers section inside groups_controller,  you can create your basic CRUD functions. Same applies to the views. Now whenever you do Group.all it should allow you to display data from the Group model in the api onto the page in the app. 
