class StaticPagesController < ApplicationController

	def top
	end

	def home
		@protocols = Protocol.order(updated_at: "DESC").limit(20)
		@discussions = Discussion.order(updated_at: "DESC").limit(20)
		@questions = Question.order(updated_at: "DESC").limit(20)
		@rank_protocols = Protocol.all.order(created_at: "DESC")
		@rank_discussions = Discussion.all.order(created_at: "DESC")
		@rank_questions = Question.all.order(created_at: "DESC")
		@tags = ActsAsTaggableOn::Tag.most_used(5)
	end

	def about
	end

	def favorites
		@protocols = 	current_user.protocol_favorites.map do |favorite|
							Protocol.find(favorite.protocol_id)
						end
		@protocols = @protocols.sort_by{|item| item.updated_at}.reverse
		@protocols = Kaminari.paginate_array(@protocols).page(params[:protocol_page]).per(20)
		@discussions = 	current_user.discuss_favorites.map do |favorite|
							Discussion.find(favorite.discussion_id)
						end
		@discussions = @discussions.sort_by{|item| item.updated_at}.reverse
		@discussions = Kaminari.paginate_array(@discussions).page(params[:discussion_page]).per(20)
		@questions = 	current_user.ques_favorites.map do |favorite|
							Question.find(favorite.question_id)
						end
		@questions = @questions.sort_by{|item| item.updated_at}.reverse
		@questions = Kaminari.paginate_array(@questions).page(params[:discussion_page]).per(20)
		@rank_protocols = Protocol.all.order(created_at: "DESC")
		@rank_discussions = Discussion.all.order(created_at: "DESC")
		@rank_questions = Question.all.order(created_at: "DESC")
		@tags = ActsAsTaggableOn::Tag.most_used(5)
	end

end
