module ThumbnailsHelper
  def thumbnail_for(micropost_link)
      @link = URI.extract(micropost_link)
      #if micropost_link =~ /\A#{URI::regexp}\z/
        begin
        
        @thumbnail = LinkThumbnailer.generate(@link[0])
        #@thumbnail = LinkThumbnailer.generate('http://bandai.com')
        rescue Exception => e
            @error = e
        end
  end   
end