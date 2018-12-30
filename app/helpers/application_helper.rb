module ApplicationHelper

	def logo_clearbit(bookmark_link)
		uri = URI.parse(bookmark_link)
		domain = PublicSuffix.parse(uri.host)
		domain_name = domain.domain
		url = "https://logo.clearbit.com/#{domain_name}"
	end


end

