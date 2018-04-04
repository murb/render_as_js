module ViewHelpers
  def render_as_js obj, options={}
    if obj.is_a?(Hash)
      return hash_to_js_obj obj
    elsif obj.is_a?(Array)
      return array_to_js_obj obj
    elsif obj.is_a?(Date)
      date_to_js_obj obj
    elsif obj.is_a?(DateTime)
      date_to_js_obj obj
    elsif obj.is_a?(String)
      string_to_js_obj obj
    elsif obj.is_a?(Symbol)
      symbol_to_js_obj obj, options
    elsif obj.is_a?(NilClass)
      nil_to_js_obj obj
    else
      return obj
    end
  end

  private

  def string_to_js_obj string
    return "\'#{sanitize string}\'".html_safe
  end

  def nil_to_js_obj obj
    return 'null'
  end

  def symbol_to_js_obj symbol, options={}
    if options[:key] and !symbol.inspect.match?(/\"/)
      return symbol.to_s.html_safe
    else
      return string_to_js_obj symbol.to_s
    end
  end

  def date_to_js_obj date
    return "new Date('#{date}')".html_safe
  end

  def array_to_js_obj arr
    "[#{arr.collect{|a| render_as_js(a)}.join(", ")}]".html_safe
  end

  def hash_to_js_obj hash
    rv = []
    hash.each do |k,v|
      rv << "#{render_as_js k, {key: true}}: #{render_as_js v}"
    end
    return "{#{rv.join(', ')}}".html_safe
  end
end