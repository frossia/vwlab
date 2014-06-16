class ReceptionsController < ApplicationController

  def create
    @reception = Reception.new( params[:reception] )

    respond_to do |format|
      if @reception.save
        format.json { render :json => @reception }
      else
        format.json { render :json => @reception.errors, status: :unprocessable_entity  }
      end
    end

  end

end
