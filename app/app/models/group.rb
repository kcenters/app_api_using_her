# require 'active_resource' 
# class Host < ActiveResource::Base
# 	self.format = :json
# 	self.site = "http://localhost:3001"
# end

 class Group 
 	include Her::Model

  	# Parsing options
  	parse_root_in_json true
  	include_root_in_json true
  	
 	# Attributes
  	attributes :id, :name
 end