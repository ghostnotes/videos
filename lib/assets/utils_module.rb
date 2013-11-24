module Utils
  class Strings
    def self.ellipse(text, max_length)
      if text.length > max_length
        text[0..max_length] + '...'
      else
        text
      end
    end

    def self.get_formatted_time(date_str)
      date = DateTime.parse(date_str)
      date.strftime('%Y/%m/%d %H:%M:%S')
    end
  end
end
