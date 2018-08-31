class Admin::ContinentsController < Admin::BaseController
  before_action :load_continent, only: :load_countries

  def load_countries
    @countries = @continent.countries.pluck(:name, :id) || []
    respond_to do |format|
      format.json{render json: @countries}
    end
  end

  private

  def load_continent
    @continent = Continent.find params[:id]
  end
end
