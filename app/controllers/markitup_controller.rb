class MarkitupController < ApplicationController
  def preview
    @text = params[:data]
  end
end