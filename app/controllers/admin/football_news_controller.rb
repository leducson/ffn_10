class Admin::FootballNewsController < Admin::BaseController
  before_action :load_football_new, except: %i(index new create)

  def index
    @football_news =
      FootballNew.newest.page(params[:page]).per(Settings.football_new_per)
  end

  def show; end

  def new
    @football_new = FootballNew.new
  end

  def create
    @football_new = FootballNew.new football_new_params
    if @football_new.save
      flash[:info] = t ".create_success"
      redirect_to admin_football_news_index_path
    else
      flash[:danger] = t ".create_error"
      render :new
    end
  end

  def edit; end

  def update
    if @football_new.update football_new_params
      flash[:info] = t ".update_success"
      redirect_to admin_football_news_index_path
    else
      flash[:danger] = t ".update_error"
      render :edit
    end
  end

  def destroy
    if @football_new.destroy
      flash[:info] = t ".destroy_success"
    else
      flash[:danger] = t ".destroy_error"
    end
    redirect_to admin_football_news_index_path
  end

  private

  def load_football_new
    @football_new = FootballNew.find_by id: params[:id]
    not_found? unless @football_new
  end

  def football_new_params
    params.require(:football_new).permit :title, :content, :image
  end
end
