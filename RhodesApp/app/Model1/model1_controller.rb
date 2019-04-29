require 'rho/rhocontroller'
require 'helpers/browser_helper'

class Model1Controller < Rho::RhoController
  include BrowserHelper

  # GET /Model1
  def index
    @model1s = Model1.find(:all)
    render :back => '/app'
  end

  def get_string
      puts "$$$ Model1_Controller.get_string with params = "+@params.to_s
      render :string => "*** RRRRRESULT !!! ***"
  end


  # GET /Model1/{1}
  def show
    @model1 = Model1.find(@params['id'])
    if @model1
      render :action => :show, :back => url_for(:action => :index)
    else
      redirect :action => :index
    end
  end

  # GET /Model1/new
  def new
    @model1 = Model1.new
    render :action => :new, :back => url_for(:action => :index)
  end

  # GET /Model1/{1}/edit
  def edit
    @model1 = Model1.find(@params['id'])
    if @model1
      render :action => :edit, :back => url_for(:action => :index)
    else
      redirect :action => :index
    end
  end

  # POST /Model1/create
  def create
    @model1 = Model1.create(@params['model1'])
    redirect :action => :index
  end

  # POST /Model1/{1}/update
  def update
    @model1 = Model1.find(@params['id'])
    @model1.update_attributes(@params['model1']) if @model1
    redirect :action => :index
  end

  # POST /Model1/{1}/delete
  def delete
    @model1 = Model1.find(@params['id'])
    @model1.destroy if @model1
    redirect :action => :index
  end
end
