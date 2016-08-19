class MemosController < ApplicationController
  before_action :logged_in_user, only: [:new, :create, :destroy]
  before_action :correct_user, only: :destroy

  def new
    @memo = current_user.memos.build
  end

  def create
    @memo = current_user.memos.build(memo_params)
    if @memo.save
      flash[:success] = "Memo created!"
      redirect_to root_url
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  def destroy
    @memo.destroy
    flash[:success] = "Memo deleted"
    redirect_to request.referrer || root_url
  end

  private

    def memo_params
      params.require(:memo).permit(:content)
    end

    def correct_user
      @memo = current_user.memos.find_by(id: params[:id])
      redirect_to root_url if @memo.nil?
    end
end
