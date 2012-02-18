module Cmsimple
  class Region
    attr_reader :snippets
    def initialize(region_hash=nil)
      @region_hash = (region_hash.presence || {}).dup
      # @region_hash.symbolize_keys! if region_hash.is_a?(Hash)
      @snippets = []
      @html = value
      build_snippets
    end

    def build_snippets
      return unless @region_hash.key?(:snippets) && @region_hash[:snippets].is_a?(Hash)
      @snippets = @region_hash[:snippets].collect {|id, hash| Snippet.new(id, hash)}
    end

    def render_snippets
      @html = value
      snippets.each do |snippet|
        snippet_view = yield snippet
        @html.gsub!(snippet.matcher, snippet_view)
      end
    end

    def value
      @region_hash[:value]
    end

    def to_s
      @html.presence || ""
    end

  end
end