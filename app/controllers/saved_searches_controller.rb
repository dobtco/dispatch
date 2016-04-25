class SavedSearchesController < ApplicationController
  include PickHelper

  before_action :authenticate_user!
  before_action :set_saved_search
  before_action :skip_authorization

  def create
    current_user.saved_searches.create(search_params: saved_search_params)
    redirect_to :back, success: t('search_saved')
  end

  def destroy
    @saved_search.destroy
    head :no_content
  end

  private

  def saved_search_params
    pick(params, *SavedSearch::PERMITTED_SEARCH_PARAMS)
  end

  def set_saved_search
    if params[:id]
      @saved_search = current_user.saved_searches.find(params[:id])
    end
  end
end
