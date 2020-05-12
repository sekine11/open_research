class StaticPagesController < ApplicationController

	def top
	end

	def home
		@protocols = Protocol.all.order(updated_at: "DESC").page(params[:page]).per(20)
		@discussions = Discussion.all.order(updated_at: "DESC").page(params[:page]).per(20)
		@questions = Question.all.order(updated_at: "DESC").page(params[:page]).per(20)
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
		@discussions = 	current_user.discuss_favorites.map do |favorite|
							Discussion.find(favorite.discussion_id)
						end
		@questions = 	current_user.ques_favorites.map do |favorite|
							Question.find(favorite.question_id)
						end
		@rank_protocols = Protocol.all.order(created_at: "DESC")
		@rank_discussions = Discussion.all.order(created_at: "DESC")
		@rank_questions = Question.all.order(created_at: "DESC")
		@tags = ActsAsTaggableOn::Tag.most_used(5)
	end

end
