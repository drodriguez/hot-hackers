class HackersController < ApplicationController
  def index
    @hackers = Hacker.order('ranking DESC').paginate(:page => params[:page] || 1)
  end

  def new
    @hacker = Hacker.new
  end

  def create
    @hacker = Hacker.new(params[:hacker])

    if @hacker.save
      redirect_to root_url, :notice => 'Hacker created!'
    else
      render :new
    end
  end
end
