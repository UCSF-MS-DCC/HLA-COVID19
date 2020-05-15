class HomeController < ApplicationController
    def index
        if current_user
            @user = current_user
        else
            @user = User.new
        end
    end
    def auth
        unless current_user
            @user = User.new
        end
    end
    def account
    end
    def age_data
        results = ActiveRecord::Base.connection.execute("select age, count(*) from subjects group by age")
        puts results.to_json
        respond_to do |format|
            format.html
            format.json { render json: { :data => results }, status: :ok }
        end
    end
    def sex_data
        results = ActiveRecord::Base.connection.execute("select sex, count(*) from subjects group by sex")
        puts results.to_json
        respond_to do |format|
            format.html
            format.json { render json: { :data => results }, status: :ok }
        end
    end
    def ethnicity_data
        results = ActiveRecord::Base.connection.execute("select ethnicity, count(*) from subjects group by ethnicity")
        puts results.to_json
        respond_to do |format|
            format.html
            format.json { render json: { :data => results }, status: :ok }
        end
    end
end
