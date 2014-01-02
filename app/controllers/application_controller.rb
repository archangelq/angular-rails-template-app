class ApplicationController < ActionController::Base
  protect_from_forgery
  def index
  end

  def cool_things
    respond_to do |format|
      format.any do
        render :json => my_cool_things
      end
    end
  end

  private
  def my_cool_things
    @my_cool_things ||= [
        {name: "AngularJS", language: "Javascript"},
        {name: "Rails", language: "Ruby"},
        {name: "Bootstrap", language: "Less (CSS)"},
        {name: "RSpec", language: "Ruby"},
        {name: "Cucumber", language: "Ruby"},
        {name: "Karma", language: "Javascript"},
        {name: "Jasmine", language: "Javascript"}
    ]
  end
end
