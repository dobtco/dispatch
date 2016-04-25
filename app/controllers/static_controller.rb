class StaticController < ApplicationController
  before_action :skip_authorization
end
