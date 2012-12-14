class PhotosController < ApplicationController
  
  before_filter :authenticate_user!, :except => [:show, :index]
  
  # GET /photos
  # GET /photos.json
  def index
    if params[:tag]
      @photos = Photo.tagged_with(params[:tag]).paginate :per_page => 25, :page => params[:page], :order => 'created_at desc'
    else
      @photos = Photo.paginate :per_page => 25, :page => params[:page], :order => 'created_at desc'
    end
    

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @photos }
    end
  end

  # GET /photos/1
  # GET /photos/1.json
  def show
    @photo = Photo.find(params[:id], :include => :rates)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @photo }
    end
  end

  # GET /photos/new
  # GET /photos/new.json
  def new
    @photo = Photo.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @photo }
    end
  end

  # GET /photos/1/edit
  def edit
    @photo = Photo.find(params[:id])
  end

  # POST /photos
  # POST /photos.json
  def create
    @photo = Photo.new(params[:photo])
    @photo.author = current_user.username
    
    respond_to do |format|
      if @photo.save
        @rate = Rate.new
        @rate.photo_id = @photo.id
        @rate.user_id = current_user.id
        @rate.value = @photo.rating
        @rate.save;
        format.html { redirect_to @photo, notice: 'Photo was successfully created.' }
        format.json { render json: @photo, status: :created, location: @photo }
      else
        format.html { render action: "new" }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /photos/1
  # PUT /photos/1.json
  def update
    @photo = Photo.find(params[:id])
    unless(Rate.where(:user_id => current_user.id, :photo_id => @photo.id).to_a != [])
      @rate = Rate.new
      @rate.photo_id = @photo.id
      @rate.user_id = current_user.id
      @rate.value = @photo.rating
    end
    respond_to do |format|
      if @photo.update_attributes(params[:photo])
        unless(Rate.where(:user_id => current_user.id, :photo_id => @photo.id).to_a != [])
          tmp = @photo.rating
          @photo.rating =((@rate.value * @photo.rates_count) + @photo.rating )/(@photo.rates_count + 1)
          @rate.value = tmp
          @rate.save
          @photo.save       
        end       
        format.html { redirect_to @photo, notice: 'Photo was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /photos/1
  # DELETE /photos/1.json
  def destroy
    @photo = Photo.find(params[:id])
    @photo.destroy

    respond_to do |format|
      format.html { redirect_to photos_url }
      format.json { head :no_content }
    end
  end
end
