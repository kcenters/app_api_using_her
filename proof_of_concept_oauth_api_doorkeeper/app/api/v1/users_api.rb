module V1
  class UsersAPI < Base
    namespace "users"

    guard_all!

    get "index" do
      User.all
    end

    get ":id" do
      User.find(params[:id])
    end
  end
end
