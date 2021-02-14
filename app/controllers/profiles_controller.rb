class ProfilesController < ApplicationController
    # ログインしている時に有効
    before_action :authenticate_user!

    def show
        # userモデルでprofileを紐付けしているからcurrent_user.profileでデータを引っ張ってこれる
        @profile = current_user.profile
    end

    def edit
        # /単数系の場合はbuildの書き方が異なる
        # if current_user.profile.present?
        #     @profile = current_user.profile
        # else
        #     @profile = current_user.build_profile
        # end
        # @profile = current_user.profile || current_user.build_profile
        # userモデルでメソッドを定義
        @profile = current_user.prepare_profile
    end

    def update
        # @profile = current_user.build_profile(profile_params)
        @profile = current_user.prepare_profile
        @profile.assign_attributes(profile_params)
        if @profile.save
            redirect_to profile_path, notice: 'プロフィール更新'
        else
            flash.now[:error] = '更新できませんでした'
            render :edit
        end  
    end

    private
    def profile_params
        params.require(:profile).permit(
            :nickname,
            :introduction,
            :gender,
            :birthday,
            :subscribed,
            :avatar
        )
    end
    
    
    
end