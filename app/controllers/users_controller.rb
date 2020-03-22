class UsersController < ApplicationController
    before_action :logged_in_user, only: [:edit, :update, :index, :destroy, :show]
    before_action :correct_user,   only: [:edit, :update, :destroy, :show, :index]
    before_action :admin_user, only: [:destroy]
    
    def new
        @user = User.new
    end
    
    def show
        @user = User.find(params[:id])
        @fav_mon1 = @user.favorites.where(fav_day: '月曜日').where(fav_period: 1)
        @fav_mon2 = @user.favorites.where(fav_day: '月曜日').where(fav_period: 2)
        @fav_mon3 = @user.favorites.where(fav_day: '月曜日').where(fav_period: 3)
        @fav_mon4 = @user.favorites.where(fav_day: '月曜日').where(fav_period: 4)
        @fav_mon5 = @user.favorites.where(fav_day: '月曜日').where(fav_period: 5)
        @fav_tue1 = @user.favorites.where(fav_day: '火曜日').where(fav_period: 1)
        @fav_tue2 = @user.favorites.where(fav_day: '火曜日').where(fav_period: 2)
        @fav_tue3 = @user.favorites.where(fav_day: '火曜日').where(fav_period: 3)
        @fav_tue4 = @user.favorites.where(fav_day: '火曜日').where(fav_period: 4)
        @fav_tue5 = @user.favorites.where(fav_day: '火曜日').where(fav_period: 5)
        @fav_wed1 = @user.favorites.where(fav_day: '水曜日').where(fav_period: 1)
        @fav_wed2 = @user.favorites.where(fav_day: '水曜日').where(fav_period: 2)
        @fav_wed3 = @user.favorites.where(fav_day: '水曜日').where(fav_period: 3)
        @fav_wed4 = @user.favorites.where(fav_day: '水曜日').where(fav_period: 4)
        @fav_wed5 = @user.favorites.where(fav_day: '水曜日').where(fav_period: 5)
        @fav_thr1 = @user.favorites.where(fav_day: '木曜日').where(fav_period: 1)
        @fav_thr2 = @user.favorites.where(fav_day: '木曜日').where(fav_period: 2)
        @fav_thr3 = @user.favorites.where(fav_day: '木曜日').where(fav_period: 3)
        @fav_thr4 = @user.favorites.where(fav_day: '木曜日').where(fav_period: 4)
        @fav_thr5 = @user.favorites.where(fav_day: '木曜日').where(fav_period: 5)
        @fav_fri1 = @user.favorites.where(fav_day: '金曜日').where(fav_period: 1)
        @fav_fri2 = @user.favorites.where(fav_day: '金曜日').where(fav_period: 2)
        @fav_fri3 = @user.favorites.where(fav_day: '金曜日').where(fav_period: 3)
        @fav_fri4 = @user.favorites.where(fav_day: '金曜日').where(fav_period: 4)
        @fav_fri5 = @user.favorites.where(fav_day: '金曜日').where(fav_period: 5)
    end
    
    def create
        @user = User.new(user_params)
        if @user.save
            log_in @user
            flash.now[:success] = '登録が完了しました！'
            redirect_to @user
        else
            render 'new'
        end
    end
    
    def edit
    end
    
    def update
        if @user.update_attributes(user_params)
            redirect_to @user
        else
            render 'edit'
        end
    end
    
    def index
        @users = User.paginate(page: params[:page])
    end
    
    def destroy
        User.find_by(id: params[:id]).destroy
        redirect_to users_url
    end
    
    private
    
        def user_params
            params.require(:user).permit(:name, :email, :password, :major, :grade)
        end
        
        def logged_in_user
            unless logged_in?
                store_location
                flash[:danger] = 'ログインが必要です。'
                redirect_to login_url
            end
        end
        
        def correct_user
            @user = User.find_by(id: params[:id])
            redirect_to root_url unless current_user?(@user)
        end
        
        def admin_user
            redirect_to root_url unless current_user.admin?
        end
        
        
        
        
end
