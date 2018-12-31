class BookmarkPolicy < ApplicationPolicy
	def update? 
		user && record.user_id == user.id
	end

	def edit?
		user && record.user_id == user.id
	end

	def destroy?
		user && record.user_id == user.id
	end
end
