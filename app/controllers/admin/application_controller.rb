# All Administrate controllers inherit from this `Admin::ApplicationController`,
# making it the ideal place to put authentication logic or other
# before_filters.
#
# If you want to add pagination or other controller-level concerns,
# you're free to overwrite the RESTful controller actions.
module Admin
  class ApplicationController < Administrate::ApplicationController
    before_filter :authenticate_admin

    def index
      search_term = params[:search].to_s.strip
      resources = Administrate::Search.new(resource_resolver, search_term).run

      # Allow deleted
      resources = resources.with_deleted if resources.respond_to?(:with_deleted)

      resources = order.apply(resources)
      resources = resources.page(params[:page]).per(records_per_page)
      page = Administrate::Page::Collection.new(dashboard, order: order)

      render locals: {
        resources: resources,
        search_term: search_term,
        page: page,
      }
    end

    # Allow deleted
    def find_resource(param)
      if resource_class.respond_to?(:with_deleted)
        resource_class.with_deleted.find(param)
      else
        resource_class.find(param)
      end
    end

    def authenticate_admin
      unless current_user.try(:admin?)
        render text: 'not authorized', status: :unauthorized
      end
    end
  end
end
