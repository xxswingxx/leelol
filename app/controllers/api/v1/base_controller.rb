class Api::V1::BaseController < ApplicationController
  respond_to :json

 def ping
   1 + 1
 end
end