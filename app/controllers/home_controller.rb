class HomeController < ApplicationController
    def index
        # render 'home/index'
        @article = Article.first
    end
    
end