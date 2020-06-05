module UserSite::Reflex
  class Index < StimulusReflex::Reflex
    def scroll(value, params)
      limit = value / 200 + 6
      @model = UserSite.search_skater(JSON.parse(params)).first(limit)
    end
  end
end