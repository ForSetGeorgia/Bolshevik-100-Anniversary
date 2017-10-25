class Admin::StoriesController < ApplicationController
  before_action :set_admin_story, only: [:show, :edit, :update, :destroy]

  # GET /admin/stories
  # GET /admin/stories.json
  def index
    @stories = Story.sorted
  end

  # GET /admin/stories/1
  # GET /admin/stories/1.json
  def show
  end

  # GET /admin/stories/new
  def new
    @story = Story.new
  end

  # GET /admin/stories/1/edit
  def edit
    set_date
  end

  # POST /admin/stories
  # POST /admin/stories.json
  def create
    @story = Story.new(story_params)

    respond_to do |format|
      if @story.save
        format.html { redirect_to [:admin,@story], notice: t('shared.msgs.success_created',
                            obj: t('activerecord.models.page_content', count: 1))}
      else
        set_date
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /admin/stories/1
  # PATCH/PUT /admin/stories/1.json
  def update
    respond_to do |format|
      if @story.update(story_params)
        format.html { redirect_to [:admin,@story], notice: t('shared.msgs.success_updated',
                            obj: t('activerecord.models.page_content', count: 1))}
      else
        set_date
        format.html { render :edit }
      end
    end
  end

  # DELETE /admin/stories/1
  # DELETE /admin/stories/1.json
  def destroy
    @story.destroy
    respond_to do |format|
      format.html { redirect_to admin_stories_url, notice: t('shared.msgs.success_destroyed',
                            obj: t('activerecord.models.page_content', count: 1))}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_story
      @story = Story.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def story_params
      permitted = Story.globalize_attribute_names + [:is_published, :published_at, :sort_order, :image_homepage, :image_share_en, :image_share_ka, :image_story]
      params.require(:story).permit(*permitted)
    end

    # set the date for the datepicker
    def set_date
      gon.published_at = @story.published_at.strftime('%m/%d/%Y %H:%M') if !@story.published_at.nil?
    end

end
