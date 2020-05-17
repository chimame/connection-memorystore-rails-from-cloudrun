class TopsController < ApplicationController
  before_action :save_test_session
  def show
    @test = session[:test]
  end

  private
  def save_test_session
    session[:test] = 'save data'
  end
end
