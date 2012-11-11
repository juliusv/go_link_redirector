class LinksController < ApplicationController
  before_filter :signed_in_user

  # GET /links
  # GET /links.json
  def index
    @links = Link.page(params[:page])
    query = params[:search_query]
 
    # TODO: Someone please implement "real" search.
    if query
      query_terms = {}
      term_conditions = []
      query.split(/\s+/).each_with_index do |term, i|
        term_conditions << "short_name LIKE :term#{i} OR url LIKE :term#{i} or comments LIKE :term#{i}"
        query_terms["term#{i}".to_sym] = "%#{term}%"
      end

      @links = @links.where(term_conditions.join(' OR '), query_terms)
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @links }
    end
  end

  # GET /links/1
  # GET /links/1.json
  def show
    @link = Link.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @link }
    end
  end

  # GET /links/new
  # GET /links/new.json
  def new
    @link = Link.new(:owner_email => current_user_email)

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @link }
    end
  end

  # GET /links/1/edit
  def edit
    @link = Link.find(params[:id])
  end

  # POST /links
  # POST /links.json
  def create
    @link = Link.new(params[:link])
    @link.last_change_email = current_user_email

    respond_to do |format|
      if @link.save
        format.html { redirect_to @link, flash: { success: 'Link was successfully created.' } }
        format.json { render json: @link, status: :created, location: @link }
      else
        format.html { render action: 'new' }
        format.json { render json: @link.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /links/1
  # PUT /links/1.json
  def update
    @link = Link.find(params[:id])
    @link.last_change_email = current_user_email

    respond_to do |format|
      if @link.update_attributes(params[:link])
        format.html { redirect_to @link, flash: { success: 'Link was successfully updated.' } }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @link.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /links/1
  # DELETE /links/1.json
  def destroy
    @link = Link.find(params[:id])
    @link.destroy

    respond_to do |format|
      format.html { redirect_to links_url }
      format.json { head :no_content }
    end
  end

  def redirect
    link = Link.find_by_short_name(params[:link])
    if link
      redirect_to link.url
    else
      redirect_to root_url, :flash => { :error => 'Link not found!' }
    end
  end

end
