class ItemAttachmentsController < ApplicationController

  def destroy
    @image = ItemAttachment.find(params[:id])
    @image.destroy
    redirect_to :back
  end

  def show
    # redirect_to :back
  end

end
