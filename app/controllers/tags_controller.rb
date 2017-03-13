class TagsController < ApplicationController
  before_filter :require_login, only: [:destroy]
end
