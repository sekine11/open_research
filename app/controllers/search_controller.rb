class SearchController < ApplicationController
	authorize_resource class: false

	def index
		if params[:q] != nil
			q = params[:q].split(/\p{blank}|\s|\t/)
		else
			q = params[:q]
		end
		@protocols = Protocol.ransack(subject_or_content_cont_any: q).result(distinct: true).includes([:user], [:protocols], [:protocol_taggings], [:protocol_favorites]).page(params[:protocol_page]).per(20)
		@discussions = Discussion.ransack(subject_or_content_cont_any: q).result(distinct: true).includes([:user], [:discussions], [:discussion_taggings], [:discuss_favorites], [:discuss_comments]).page(params[:discussion_page]).per(20)
		@questions = Question.ransack(subject_or_content_cont_any: q).result(distinct: true).includes([:user], [:questions], [:question_taggings], [:ques_favorites], [:ques_comments]).page(params[:question_page]).per(20)
		@rank_protocols = Protocol.order('impressions_count DESC').take(10)
		@rank_discussions = Discussion.order('impressions_count DESC').take(10)
		@rank_questions = Question.order('impressions_count DESC').take(10)
		@tags = ActsAsTaggableOn::Tag.most_used(5)
	end
	
end
