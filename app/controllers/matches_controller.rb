class MatchesController < ApplicationController
  def new
    @match = Match.new
    session[:match_token] = @match.token
  end

  def create
    match_token = session[:match_token]
    session[:match_token] = nil
    winner = Match.calculate_rankings! params[:match], match_token
    flash[:notice] = "#{winner.username} wins!"
    redirect_to new_match_url
  end
end
