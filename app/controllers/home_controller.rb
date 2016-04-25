class HomeController < ApplicationController
  def index
    skip_authorization

    @recent_opportunities = Opportunity.
                              posted.
                              order_by_recently_posted.
                              limit(5)
  end
end
