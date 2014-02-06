module V1
  class Base < ApplicationAPI
    version "v1", :using => :path

    mount SampleAPI
    mount SecretAPI
    mount UsersAPI
    mount GroupsAPI
  end
end
