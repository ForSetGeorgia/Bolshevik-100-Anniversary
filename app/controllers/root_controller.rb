# Non-resource pages
class RootController < ApplicationController
  def index
    @show_page_title = false
    @stories = Story.sorted
    @about = PageContent.only_title.find_by(name: 'about')
  end

  def about
    @show_page_title = false
    @about = PageContent.find_by(name: 'about')
    @images = AboutImage.sorted
  end

  def about_eurasianet
    @show_page_title = false
    @about = PageContent.find_by(name: 'about_eurasianet')
  end

  def stories
    redirect_to root_path
  end

  def story_show
    @show_page_title = false
    begin


      if user_signed_in? && current_user.is?(['super_admin', 'site_admin'])
        @story = Story.friendly.find(params[:id])
      else
        @story = Story.friendly.published.find(params[:id])
      end
      if @story.nil?
        redirect_to root_path,
              alert: t('shared.msgs.does_not_exist')
      end

      # get next/previous links
      # @next, @previous = nil
      stories = Story.published.sorted#.only_title

      story_index = stories.index{|x| x.id == @story.id}

      if story_index.present?
        prev_n = 0
        next_n = 0

        ln = stories.length
        [1,2].each {|e|
          prev_n = e if story_index-e >= 0
          next_n = e if story_index+e <= ln
        }
        @prev = stories.slice(story_index-prev_n, prev_n)#..story_index-1
        @next = stories.slice(story_index+1, next_n)
      end

      @prev = [] if @prev.nil?
      @next = [] if @next.nil?
      # if there are more stories than this one, get the ids for the next/prev pages
      # if stories.length > 1
      #   # find this story
      #   idx = stories.index{|x| x.id == @story.id}
      #   if idx.present?
      #     # next
      #     @next = if idx == stories.length-1
      #        stories[0]
      #     else
      #       stories[idx+1]
      #     end

      #     # previous
      #     @previous = if idx == 0
      #       stories[stories.length-1]
      #     else
      #       stories[idx-1]
      #     end
      #   end
      #   # if there is only one other story, only save it as next
      #   @previous = nil if @next.id == @previous.id
      # end


    rescue ActiveRecord::RecordNotFound => e
      redirect_to root_path,
                alert: t('shared.msgs.does_not_exist')
    end
end

end
