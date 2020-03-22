class LecturesController < ApplicationController
    
    before_action :logged_in_user, only: [:lecture_review, :lecture_answer, :lecture_favorite]
    before_action :correct_user,   only: [:lecture_review, :lecture_answer, :lecture_favorite]
    
    def lecture_list
        @lectures = Lecture.all
    end
    
    def show
        @lecture = Lecture.find_by(id: params[:id])
        @reviews = @lecture.reviews
        @understanding_score = understanding_calculation
        @getting_score = getting_calculation
        @interest_score = interest_calculation
        @attendance_score = attendance_calculation
        @method_score = method_calculation
        @score_score = score_calculation
        @tokutan_score = tokutan_calculation
    end
    
    def lecture_item
        @lecture = Lecture.find_by(id: params[:id])
    end
    
    def lecture_search
        @lectures = Lecture.all.order('ev_score DESC')
        if not params[:search][:search_keyword].empty?
            s_keyword = "%" + params[:search][:search_keyword] + "%"
            @lectures = Lecture.where("lec_name LIKE ?", s_keyword )
        end
        
        if not params[:search][:search_quarter].empty?
            @lectures = @lectures.where(t_quarter: params[:search][:search_quarter])
        end
        if not params[:search][:search_day].empty?
            @lectures = @lectures.where(t_day: params[:search][:search_day])
        end
        if not params[:search][:search_period].empty?
            @lectures = @lectures.where(t_period: params[:search][:search_period])
        end
        if not params[:search][:search_group].empty?
            @lectures = @lectures.where(group: params[:search][:search_group])
        end
        if not params[:search][:search_method].empty?
            @lectures = @lectures.where("ev_method LIKE ?", params[:search][:search_method])
        end
        if not params[:search][:search_major].empty?
            @lectures = @lectures.where(en_major: params[:search][:search_major])
        end
        if not params[:search][:search_attendance].empty?
            @lectures = @lectures.where(ev_attendance: params[:search][:search_attendance])
        end
        if not params[:search][:search_grade].empty?
            @lectures = @lectures.where(en_grade: params[:search][:search_grade])
        end
        if params[:search][:check_highscore] == '1'
            @lectures = @lectures.where('ev_score >= ?', 85)
        end
        if params[:search][:check_getting_easily] == '1'
            @lectures = @lectures.where('ev_getting >= ?', 85)
        end
        if params[:search][:check_understanding] == '1'
            @lectures = @lectures.where('ev_understanding >= ?', 3.5)
        end
        
        render 'lecture_list'
    end
    
    def lecture_review
        @lecture = Lecture.find_by(id: params[:lecture_id])
        @reviewer = User.find_by(id: params[:user_id])
    end
    
    def lecture_answer
        @lecture = Lecture.find_by(id: params[:lecture_id])
        @reviewer = User.find_by(id: params[:user_id])
        le_params = lecture_params
        @review = @lecture.reviews.build(user_id: @reviewer.id, 
                                understanding: le_params[:review_understanding],
                                getting: le_params[:review_getting],
                                interest: le_params[:review_interest],
                                score: le_params[:review_score],
                                tokutan: le_params[:review_tokutan],
                                attendance: le_params[:review_attendance],
                                method: le_params[:review_method],
                                comment: le_params[:review_free])
        if @review.save
            flash[:success] = 'レビューが完了しました'
            redirect_to lecture_list_path
        else
            render 'recture_review'
        end
    end
    
    def lecture_favorite
        @lecture = Lecture.find_by(id: params[:lecture_id])
        @user = User.find_by(id: params[:user_id])
        @favorite_lecture = @user.favorites.build(user_id: @user.id,
                                                  lec_id: @lecture.id,
                                                  fav_day: @lecture.t_day,
                                                  fav_period: @lecture.t_period)
        if @favorite_lecture.save
            flash[:success] = "#{@lecture.lec_name}がMy時間割に追加されました。"
            redirect_to "/lectures/#{@lecture.id}"
        else
            render 'lectures/show'
        end
    end
    
    def lecture_delete
        user = User.find_by(id: params[:user_id])
        favorite = user.favorites.find_by(lec_id: params[:lecture_id])
        favorite.destroy
        redirect_to user
    end
    
    
    private
        
        def logged_in_user
            unless logged_in?
                store_location
                flash[:danger] = 'ログインが必要です。'
                redirect_to login_url
            end
        end
        
        def understanding_calculation
            the_lecture = Lecture.find_by(id: params[:id])
            reviews = the_lecture.reviews
            if reviews.count == 0
                score = 3.0
            else
                understanding_score = 0
                for review in reviews do
                    understanding_score = understanding_score + review.understanding
                end
                score = BigDecimal((understanding_score.to_f / reviews.count.to_f).to_s).floor(1).to_f
                return score
            end
        end
        
        def getting_calculation
            the_lecture = Lecture.find_by(id: params[:id])
            reviews = the_lecture.reviews
            if reviews.count == 0
                score = 3.0
            else
                getting_score = 0
                for review in reviews do
                    getting_score = getting_score + review.getting
                end
                score = BigDecimal((getting_score.to_f / reviews.count.to_f).to_s).floor(1).to_f
                return score
            end
        end
        
        def interest_calculation
            the_lecture = Lecture.find_by(id: params[:id])
            reviews = the_lecture.reviews
            if reviews.count == 0
                score = 3.0
            else
                interest_score = 0
                for review in reviews do
                    interest_score = interest_score + review.interest
                end
                score = BigDecimal((interest_score.to_f / reviews.count.to_f).to_s).floor(1).to_f
                return score
            end
        end
        
        def attendance_calculation
            the_lecture = Lecture.find_by(id: params[:id])
            reviews = the_lecture.reviews
            at = reviews.where(attendance: '毎回出席有').count
            at_un = reviews.where(attendance: 'ときどき出席有').count
            un = reviews.where(attendance: '出席無し').count
            max = [at, at_un, un].max
            if max == at
                score = '毎回出席有'
            elsif max == at_un
                score = 'ときどき出席有'
            else
                score = '出席無し'
            end
            return score
        end
        
        def method_calculation
            the_lecture = Lecture.find_by(id: params[:id])
            reviews = the_lecture.reviews
            at = reviews.where(attendance: 'テスト100%').count
            at_un = reviews.where(attendance: 'テストと課題').count
            un = reviews.where(attendance: '課題100%').count
            max = [at, at_un, un].max
            if max == at
                score = 'テスト100%'
            elsif max == at_un
                score = 'テストと課題'
            else
                score = '課題100%'
            end
            return score
        end
        
        def score_calculation
            the_lecture = Lecture.find_by(id: params[:id])
            reviews = the_lecture.reviews
            if reviews.count == 0
                score = 80
            else
                score_score = 0
                for review in reviews do
                    score_score = score_score + review.score
                end
                score = BigDecimal((score_score.to_f / reviews.count.to_f).to_s).floor(1).to_f
                return score
            end
        end
        
        def tokutan_calculation
            the_lecture = Lecture.find_by(id: params[:id])
            reviews = the_lecture.reviews
            if reviews.count == 0
                score = 80
            else
                at = reviews.where(tokutan: '得単').count.to_f
                un = reviews.where(tokutan: '落単').count.to_f
                score = BigDecimal((at.to_f / (at.to_f+un.to_f)).to_s).floor(1).to_f*100
            end
            return score
        end

        def lecture_params
           params.require(:review).permit(:review_understanding, 
                                          :review_attendance,
                                          :review_getting,
                                          :review_interest,
                                          :review_free,
                                          :review_score,
                                          :review_tokutan,
                                          :review_free)
        end
        
        def correct_user
            @user = User.find_by(id: params[:user_id])
            redirect_to root_url unless current_user?(@user)
        end
    end