class HomeController < ApplicationController
  def index
    @recent_opportunities = Opportunity.
                              posted.
                              order_by_recently_posted.
                              limit(5)
  end
end
