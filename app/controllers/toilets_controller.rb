require 'open-uri'
require 'json'

class ToiletsController < ApplicationController
  # GET /toilets
  # GET /toilets.json
  def index
   # @toilets = Toilet.all
   
    

    if params.key?(:lat)
      lat = params[:lat]
      lng = params[:lng]
    else
      lat= 23.5;
      lng = 121.0;
    end

    condition = ""  
    isFirst = true
    for has_condition in ['has_male', 'has_female', 'has_both', 'has_free_access', 'has_family' ] do
      if params.key?( has_condition )
        if params[has_condition] =='true'
          if isFirst 
            condition = has_condition + " = 't'"
            isFirst = false
          else
            condition = condition + " and " + has_condition + " = 't'"  
          end
        end
      end
    end
    
   
    @toilets = Toilet.where( [" abs( latitude - ?) < 0.01 and abs(longitude - ?) < 0.01 ", lat, lng ] ).where( condition )
    
   # @toilets = @toilets.where( ['has_both = ?', true] );
    
    
    @condition_toilet  = Toilet.new
     
    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => { :toilets => @toilets, :center => [lat, lng] } }
    end
  end


  # GET /toilets/1
  # GET /toilets/1.json
  def show
    @toilet = Toilet.find(params[:id])
    cleanness = ToiletRating.where( :toilet_id => params[:id]).group( :toilet_id).average( :cleanness ).values.first 
    safety = ToiletRating.where( :toilet_id => params[:id]).group( :toilet_id).average( :safety ).values.first
    privacy = ToiletRating.where( :toilet_id => params[:id]).group( :toilet_id).average( :privacy ).values.first
    comfort = ToiletRating.where( :toilet_id => params[:id]).group( :toilet_id).average( :comfort ).values.first

    @score = {:cleanness=> cleanness, :safety => safety, :privacy=> privacy, :comfort=> comfort }
    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => { :toilet => @toilet , :score=>@score} }
    end
  end

  # GET /toilets/new
  # GET /toilets/new.json
  def new
    @toilet = Toilet.new
   
    if !(params.has_key?(:latitude) and params.has_key?(:longitude)):
        redirect_to toilets_path 
        return 
    end 
    @toilet.latitude = params[:latitude]
    @toilet.longitude = params[:longitude]

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @toilet }
    end
  end

  # GET /toilets/1/edit
  def edit
    @toilet = Toilet.find(params[:id])
  end

  # POST /toilets
  # POST /toilets.json
  def create
    @toilet = Toilet.new(params[:toilet])

    respond_to do |format|
      if @toilet.save
        format.html { redirect_to @toilet, :notice => 'Toilet was successfully created.' }
        format.json { render :json => @toilet, :status => :created, :location => @toilet }
      else
        format.html { render :action => "new" }
        format.json { render :json => @toilet.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /toilets/1
  # PUT /toilets/1.json
  def update
    @toilet = Toilet.find(params[:id])

    respond_to do |format|
      if @toilet.update_attributes(params[:toilet])
        format.html { redirect_to @toilet, :notice => 'Toilet was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @toilet.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /toilets/1
  # DELETE /toilets/1.json
  def destroy
    @toilet = Toilet.find(params[:id])
    @toilet.destroy

    respond_to do |format|
      format.html { redirect_to toilets_url }
      format.json { head :no_content }
    end
  end
end
