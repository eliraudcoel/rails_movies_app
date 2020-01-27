module Api
    module V1
      class Api::UsersController < ApiController
  
        def show
            #TODO : make it retrieve from header token
            @user = User.last
        end
      end
    end
  end