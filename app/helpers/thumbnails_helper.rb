module ThumbnailsHelper
  def thumbnail_for(micropost_link)
      @link = URI.extract(micropost_link)
      if micropost_link =~ /\A#{URI::regexp}\z/
        begin
        @thumbnail = LinkThumbnailer.generate(micropost_link)
        rescue LinkThumbnailer::Exceptions => e
        # do something
        end
      else
          if @link.empty? && @link[0] =~ /\A#{URI::regexp}\z/
            @thumbnail = LinkThumbnailer.generate(@link[0])
          end
      end
  end   
end