class MainController < ApplicationController
    def index
        @all_articles = Article.all
        @all_users = User.all

        @all_articles.each do|all|
            all.text = all.text.truncate(150)
        end
    end
end
