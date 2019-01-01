module ApplicationHelper

	def logo_clearbit(bookmark_link)
		uri = URI.parse(bookmark_link)
		domain = PublicSuffix.parse(uri.host)
		domain_name = domain.domain
		url = "https://logo.clearbit.com/#{domain_name}"
	end

	def current_page_params
    # Modify this list to whitelist url params for linking to the current page
    # request.query_parameters.merge
    request.params.slice("query")
	end


end

