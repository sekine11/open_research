class SearchController < ApplicationController

	def index
		if params[:q] != nil
			q = params[:q].split(/\p{blank}|\s|\t/)
		else
			q = params[:q]
		end
		@protocols = Protocol.ransack(subject_or_content_cont_any: q).result(distinct: true).page(params[:protocol_page]).per(20)
		@discussions = Discussion.ransack(subject_or_content_cont_any: q).result(distinct: true).page(params[:discussion_page]).per(20)
		@questions = Question.ransack(subject_or_content_cont_any: q).result(distinct: true).page(params[:question_page]).per(20)
		@rank_protocols = Protocol.all.order(created_at: "DESC")
		@rank_discussions = Discussion.all.order(created_at: "DESC")
		@rank_questions = Question.all.order(created_at: "DESC")
		@tags = ActsAsTaggableOn::Tag.most_used(5)
	end
	
end
