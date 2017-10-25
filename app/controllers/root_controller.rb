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
    @images = AboutImage.sorted
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

      # get next/previous links
      @next, @previous = nil
      stories = Story.published.sorted.only_title
      # if there are more stories than this one, get the ids for the next/prev pages
      if stories.length > 1
        # find this story
        idx = stories.index{|x| x.id == @story.id}
        if idx.present?
          # next
          @next = if idx == stories.length-1
             stories[0]
          else
            stories[idx+1]
          end

          # previous
          @previous = if idx == 0
            stories[stories.length-1]
          else
            stories[idx-1]
          end
        end

        # if there is only one other story, only save it as next
        @previous = nil if @next.id == @previous.id
      end


    rescue ActiveRecord::RecordNotFound => e
      redirect_to root_path,
                alert: t('shared.msgs.does_not_exist')
    end
end

end
