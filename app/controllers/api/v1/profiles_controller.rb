module Api
    module V1
        class ProfilesController < ApplicationController
            def index
                render json: Profile.all
            end
        end
    end
end