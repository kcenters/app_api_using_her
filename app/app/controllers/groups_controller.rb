class GroupsController < ApplicationController
	before_filter :authenticate_user!
	
 	def index
 		@groups = Group.all
 	end

 	def edit 
 		@group = Group.find(params[:id])
 	end

 	def new
 		@group = Group.new
 	end

 	def update 
		@group = Group.find(params[:id])
		@group.assign_attributes(group_params)
		 if @group.save
		 	flash[:notice] = "Group successfully updated"
		 	redirect_to @group
		 else
		 	render :edit
		 end
	end

	def create 
		@group = Group.new(group_params)
		if @group.save 
			flash[:notice] = "Command created successfully"
			redirect_to @group
		else
			render :new
		end
	end


	def show
		@group = Group.find(params[:id])
	end


	private

    # Never trust parameters from the scary internet, only allow the white list through.
    def group_params
      params.require(:group).permit(:name)
    end

end
