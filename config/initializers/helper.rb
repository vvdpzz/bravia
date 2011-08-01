class Helper
  
  def self.truncate(text, options = {})
    options.reverse_merge!(:length => 30)
    text.truncate(options.delete(:length), options) if text
  end
  
  def self.markdown(text)
    options = [:hard_wrap, :filter_html, :autolink, :no_intraemphasis, :fenced_code, :gh_blockcode]
    Helper.syntax_highlighter(Redcarpet.new(text, *options).to_html).html_safe
  end

  def self.syntax_highlighter(html)
    doc = Nokogiri::HTML(html)
    doc.search("//pre[@lang]").each do |pre|
      pre.replace Albino.colorize(pre.text.rstrip, pre[:lang])
    end
    doc.to_s
  end
  
end