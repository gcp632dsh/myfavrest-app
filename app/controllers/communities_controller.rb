class CommunitiesController < ApplicationController
    skip_before_action :authenticate_user!, only: [:index, :show]

    def index
        @communities = Community.where(publish_flg: 0)
        @posts = Post.where(community_id: @communities.ids)
        @posts = @posts.page(params[:page])
    end

    def show
        @community = Community.find(params[:id])
        @posts = Post.where(community_id: @community.id)
        @posts = @posts.page(params[:page])
    end

    def edit
        @community = Community.find(params[:id])
        @code = Code.all
    end

    def update
        community = current_user.communities.find(params[:id])
        community.update!(community_params)
        redirect_to community_url(community) notice:"投稿「#{community.name}」を更新しました。"
    end

    def destroy
        community = current_user.communities.find(params[:id])
        community.destroy
        redirect_to communities_url, notice: "投稿「#{community.name}」を削除しました。"
    end

    private

        def community_params
            params.require(:community).permit(:name,:create_user_id,:publish_flg)
        end

end
