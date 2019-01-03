class ArticlePolicy < ApplicationPolicy
	def show? 
		user && record.user_id == user.id
	end
end
