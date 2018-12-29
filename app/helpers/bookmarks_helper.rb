module BookmarksHelper
	def domain_name(bookmark)
		page = MetaInspector.new(bookmark.link)
		page.host
	end
end
