class Api::V1::BaseController < ApplicationController
  respond_to :json
  skip_before_filter :authenticate_user!, only: [:ping]

  def ping
    respond_with({ :status => 'OK' })
  end
end