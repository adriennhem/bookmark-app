FactoryBot.define do
	factory :user do 
		email { "adrien@gmail.com" }
		password { "hello123" }
		password_confirmation { "hello123" }
	end

	factory :like do 
		bookmark_id { 1 }
		user_id { 2 }
	end
end