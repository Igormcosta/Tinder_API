module Api
    module V1
        class ProfilesController < ApplicationController
            def index
                render json: Profile.order(:name)
            end

            def show
                render json: Profile.find(params[:id])
            end

            def create 
                profile = Profile.create(profile_params)

                if profile.save
                    render jason: profile, status: :created
                else
                    render jason: { errors: profile.errors.full_messages }, status: :bad_request
                end
            end

            def update

                profile = Profile.find(params[:id])

                if profile.update(profile_params)
                    render jason: profile, status: :accepted
                else
                    render jason: { errors: profile.errors.full_messages }, status: :bad_request
                end
            end

            def destroy
                profile = Profile.find(params[:id])

                if profile.destroy
                    render jason: profile, status: :accepted
                else
                    render jason: { errors: profile.errors.full_messages }, status: :bad_request
                end
            end

            private

            def profile_params
                params.require(:profile).permit(:name, :birth_date, :genre)
            end
        end
    end
end