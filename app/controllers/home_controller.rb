class HomeController < ApplicationController
  SALES_PAGE_URL = 'https://www.dobt.co'

  def index
    @recent_opportunities = Opportunity.
                              published.
                              order_by_recently_posted.
                              limit(5)
  end
end
