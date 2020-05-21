class StaticPagesController < ApplicationController
	authorize_resource class: false
	rescue_from CanCan::AccessDenied do |exception|
	  redirect_to home_url, alert: "新規登録もしくは、ログインしてください。"
	end

	def top
	end

	def home
		@protocols = Protocol.includes([:user], [:protocols], [:protocol_taggings], [:protocol_favorites]).order(updated_at: "DESC").take(20)
		@discussions = Discussion.includes([:user], [:discussions], [:discussion_taggings], [:discuss_favorites], [:discuss_comments]).order(updated_at: "DESC").take(20)
		@questions = Question.includes([:user], [:questions], [:question_taggings], [:ques_favorites], [:ques_comments]).order(updated_at: "DESC").take(20)
		@rank_protocols = Protocol.order('impressions_count DESC').take(10)
		@rank_discussions = Discussion.order('impressions_count DESC').take(10)
		@rank_questions = Question.order('impressions_count DESC').take(10)
		@tags = ActsAsTaggableOn::Tag.most_used(5)
	end

	def about
	end

	def favorites
		@protocols = 	current_user.favorite_protocols.includes([:user], [:protocols], [:protocol_taggings], [:protocol_favorites]).order(updated_at: "DESC").page(params[:protocol_page]).per(20)
		@discussions = 	current_user.favorite_discussions.includes([:user], [:discussions], [:discussion_taggings], [:discuss_favorites], [:discuss_comments]).order(updated_at: "DESC").page(params[:discussion_page]).per(20)
		@questions = 	current_user.favorite_questions.includes([:user], [:questions], [:question_taggings], [:ques_favorites], [:ques_comments]).order(updated_at: "DESC").page(params[:discussion_page]).per(20)
		@rank_protocols = Protocol.order('impressions_count DESC').take(10)
		@rank_discussions = Discussion.order('impressions_count DESC').take(10)
		@rank_questions = Question.order('impressions_count DESC').take(10)
		@tags = ActsAsTaggableOn::Tag.most_used(5)
	end

	def tags
		if params[:tag]
			@protocols = 	Protocol.tagged_with(params[:tag]).includes([:user], [:protocols], [:protocol_taggings], [:protocol_favorites]).order(updated_at: "DESC").page(params[:protocol_page]).per(20)
			@discussions = 	Discussion.tagged_with(params[:tag]).includes([:user], [:discussions], [:discussion_taggings], [:discuss_favorites], [:discuss_comments]).order(updated_at: "DESC").page(params[:discussion_page]).per(20)
			@questions = 	Question.tagged_with(params[:tag]).includes([:user], [:questions], [:question_taggings], [:ques_favorites], [:ques_comments]).order(updated_at: "DESC").page(params[:discussion_page]).per(20)
			@rank_protocols = Protocol.order('impressions_count DESC').take(10)
			@rank_discussions = Discussion.order('impressions_count DESC').take(10)
			@rank_questions = Question.order('impressions_count DESC').take(10)
			@tags = ActsAsTaggableOn::Tag.most_used(5)
		else
			redirect_to home_path, alert: "タグの選択が必須です"
		end
	end
end
