# Non-resource pages
class RootController < ApplicationController
  def index
    @show_page_title = false
    @stories = Story.sorted
    @about = PageContent.only_title.find_by(name: 'about')
    @about_eurasianet = PageContent.only_title.find_by(name: 'about_eurasianet')
  end

  def about
    @about = PageContent.find_by(name: 'about')
  end

  def about_eurasianet
    @about = PageContent.find_by(name: 'about_eurasianet')
  end

  def stories
    redirect_to root_path
  end

  def story_show
    begin
      @story = Story.friendly.published.find(params[:id])

      if @story.nil?
        redirect_to root_path,
              alert: t('shared.msgs.does_not_exist')
      end

    rescue ActiveRecord::RecordNotFound => e
      redirect_to root_path,
                alert: t('shared.msgs.does_not_exist')
    end
end

end
