class ApplicationController < ActionController::Base
  protect_from_forgery
  def index
  end

  def cool_things
    respond_to do |format|
      format.any do
        render :json => [{name: "AngularJS", language: "Javascript"},
                         {name: "Rails", language: "Ruby"},
                         {name: "Bootstrap", language: "Less (CSS)"}]
      end
    end
  end
end
