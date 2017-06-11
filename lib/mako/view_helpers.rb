# frozen_string_literal: true

module ViewHelpers
  # Returns today's date in Day, Date Month Year format
  #
  # @return [String]
  def today
    Time.now.strftime('%A, %d %B %Y')
  end

  # Returns the current time in month day year hour:minute:second format
  #
  # @return [String]
  def last_updated
    Time.now.strftime('%d %b %Y %H:%M:%S')
  end

  # Returns a string with anchor tag links to each Feed generated on the page
  #
  # @return [String]
  def quick_nav(feeds)
    feeds.select { |feed| feed.articles.size.positive? }
         .each_with_index.inject('') do |string, (feed, index)|
      string += "<a href='#feed-#{index}' class='quick-nav-item'>#{feed.title} <div class='circle'>#{feed.articles.size}</div></a>"
      string
    end
  end
end
