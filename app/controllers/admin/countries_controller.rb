class Admin::CountriesController < Admin::BaseController
  before_action :load_country, except: %i(index new create)

  def index
    @countries = Country.newest.page(params[:page]).per Settings.country_per
  end

  def new
    @country = Country.new
  end

  def create
    @country = Country.new country_params
    if @country.save
      flash[:info] = t ".create_success"
      redirect_to admin_countries_path
    else
      flash[:danger] = t ".create_error"
      render :new
    end
  end

  def edit; end

  def update
    if @country.update country_params
      flash[:info] = t ".update_success"
      redirect_to admin_countries_path
    else
      flash[:danger] = t ".update_error"
      render :edit
    end
  end

  def destroy
    if @country.destroy
      flash[:info] = t ".destroy_success"
    else
      flash[:danger] = t ".destroy_error"
    end
    redirect_to admin_countries_path
  end

  private

  def load_country
    @country = Country.find params[:id]
  end

  def country_params
    params.require(:country).permit :name, :continent_id
  end
end
