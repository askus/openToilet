class ToiletRatingsController < ApplicationController
  # GET /toilet_ratings
  # GET /toilet_ratings.json
  def index
    @toilet_ratings = ToiletRating.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @toilet_ratings }
    end
  end

  # GET /toilet_ratings/1
  # GET /toilet_ratings/1.json
  def show
    @toilet_rating = ToiletRating.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @toilet_rating }
    end
  end

  # GET /toilet_ratings/new
  # GET /toilet_ratings/new.json
  def new

    @toilet_rating = ToiletRating.new
    if params.has_key?( :toilet_id)  
      @toilet_rating.toilet_id = params[:toilet_id]  
    end
    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @toilet_rating }
    end
  end

  # GET /toilet_ratings/1/edit
  def edit
    @toilet_rating = ToiletRating.find(params[:id])
  end

  # POST /toilet_ratings
  # POST /toilet_ratings.json
  def create
    @toilet_rating = ToiletRating.new(params[:toilet_rating])

    respond_to do |format|
      if @toilet_rating.save
        format.html { redirect_to @toilet_rating, :notice => 'Toilet rating was successfully created.' }
        format.json { render :json => @toilet_rating, :status => :created, :location => @toilet_rating }
      else
        format.html { render :action => "new" }
        format.json { render :json => @toilet_rating.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /toilet_ratings/1
  # PUT /toilet_ratings/1.json
  def update
    @toilet_rating = ToiletRating.find(params[:id])

    respond_to do |format|
      if @toilet_rating.update_attributes(params[:toilet_rating])
        format.html { redirect_to @toilet_rating, :notice => 'Toilet rating was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @toilet_rating.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /toilet_ratings/1
  # DELETE /toilet_ratings/1.json
  def destroy
    @toilet_rating = ToiletRating.find(params[:id])
    @toilet_rating.destroy

    respond_to do |format|
      format.html { redirect_to toilet_ratings_url }
      format.json { head :no_content }
    end
  end
end
