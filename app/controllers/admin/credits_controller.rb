class Admin::CreditsController < Admin::BaseController
  before_action :load_credit, except: %i(index new create)

  def index
    @credits =
      Credit.includes(:user).newest.page(params[:page]).per Settings.credit_per
  end

  def new
    @credit = Credit.new
  end

  def create
    @credit = Credit.new credit_params
    if @credit.save
      flash[:info] = t ".success"
      redirect_to admin_credits_path
    else
      flash[:danger] = t ".error"
      render :new
    end
  end

  def edit; end

  def update
    if @credit.update_attributes credit_params
      flash[:info] = t ".success"
      redirect_to admin_credits_path
    else
      flash[:danger] = t ".error"
      render :edit
    end
  end

  def destroy
    if @credit.destroy
      flash[:info] = t ".success"
    else
      flash[:danger] = t ".success"
    end
    redirect_to admin_credits_path
  end

  def quick_set_type
    begin
      if @credit.recharge!
        money = @credit.user.money.to_f
        @credit.user.update_attributes money: (money + @credit.amount.to_f)
        flash[:info] = t ".success"
      else
        flash[:danger] = t ".error"
      end
      redirect_to admin_credits_path
    rescue ActiveRecord::RecordInvalid => ex
      flash[:danger] = ex.record.errors
      redirect_to admin_credits_path
    end
  end

  private

  def load_credit
    @credit = Credit.find params[:id]
  end

  def credit_params
    params.require(:credit).permit :credit_type, :amount, :user_id
  end
end
