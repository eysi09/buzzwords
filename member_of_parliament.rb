require_relative 'settings.rb'

class MemberOfParliament

  # 'uri' is the URI string to a MP's page on the Althingi website 
  # that contains that MP's speeches for a given parliament year.
  def initialize(name, details, uri)
    @name     = name
    @details  = details
    @page     = Mechanize.new.get(uri)
  end

  def get_name
    @name
  end

  def get_details
    @details
  end

  def get_party
    @details.split(',')[1].split(' ')[0]
  end

  # Speeches that haven't been transcribed are left out
  def get_word_freq
    speech_links = get_links_to_speeches
    word_freq = Hash.new(0)
    
    speech_links.each do |link|
      speech_page = link.click
      if (speech_obj = speech_page.at SPEECH_DIV_IDENTIFIER)
        speech = speech_obj.text
        words  = speech.split(' ')
        words.each{ |word| word_freq[clean_str(word)] += 1 }
      end
    end

    word_freq.sort_by{ |x,y| y }.reverse
  end

  def write_freq_to_csv
    word_freq = get_word_freq
    file_name = 'data/' + @name + '.csv'
    File.open(file_name, 'w:UTF-8') do |file|
      word_freq.each do |wf|
        word  = wf[0]
        freq  = wf[1]
        file.write(word.to_s + ';' + freq.to_s + "\n")
      end
    end
  end

  def get_links_to_speeches
    @page.links.select{|l| l.uri.to_s.include? SPEECH_LINK_IDENTIFIER}
  end

  private

  # Remove non-word characters and spaces
  def clean_str(word)
    word.gsub(/[^\w]/, '').downcase
  end

end