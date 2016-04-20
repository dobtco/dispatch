class HomeController < ApplicationController
  SALES_PAGE_URL = 'https://www.dobt.co'.freeze

  def index
    @recent_opportunities = Opportunity.
                              posted.
                              order_by_recently_posted.
                              limit(5)
  end
end
