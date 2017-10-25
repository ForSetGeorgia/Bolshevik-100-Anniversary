class Admin::AboutImagesController < ApplicationController
  before_action :set_about_image, only: [:show, :edit, :update, :destroy]

  # GET /admin/about_images
  # GET /admin/about_images.json
  def index
    @about_images = AboutImage.sorted
  end

  # GET /admin/about_images/1
  # GET /admin/about_images/1.json
  def show
    redirect_to admin_about_images_path
  end

  # GET /admin/about_images/new
  def new
    @about_image = AboutImage.new
  end

  # GET /admin/about_images/1/edit
  def edit
  end

  # POST /admin/about_images
  # POST /admin/about_images.json
  def create
    @about_image = AboutImage.new(about_image_params)

    respond_to do |format|
      if @about_image.save
        format.html { redirect_to admin_about_images_path, notice: t('shared.msgs.success_created',
                            obj: t('activerecord.models.about_image', count: 1))}
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /admin/about_images/1
  # PATCH/PUT /admin/about_images/1.json
  def update
    respond_to do |format|
      if @about_image.update(about_image_params)
        format.html { redirect_to admin_about_images_path, notice: t('shared.msgs.success_updated',
                            obj: t('activerecord.models.about_image', count: 1))}
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /admin/about_images/1
  # DELETE /admin/about_images/1.json
  def destroy
    @about_image.destroy
    respond_to do |format|
      format.html { redirect_to admin_about_images_url, notice: t('shared.msgs.success_destroyed',
                            obj: t('activerecord.models.about_image', count: 1))}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_about_image
      @about_image = AboutImage.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def about_image_params
      permitted = AboutImage.globalize_attribute_names + [:sort_order, :position, :image_en, :image_ru]
      params.require(:about_image).permit(*permitted)
    end
end
