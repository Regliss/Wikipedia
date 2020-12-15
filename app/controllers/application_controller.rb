class ApplicationController < ActionController::Base
    before_action :retrieve_current_user
    # before_action :retrieve_current_ranking

    def retrieve_current_user
        if session[:user_token] != nil
            user = User.find_by(id: session[:user_token])
            @current_user = user
        end
    end

    # def retrieve_current_ranking
    #     if session[:ranking_token] != nil
    #         ranking = Ranking.find_by(id: session[:ranking_token])
    #         @current_ranking = ranking
    #     end
    # end
end
