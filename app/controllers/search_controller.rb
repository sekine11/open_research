class SearchController < ApplicationController

	def index
		if params[:q] != nil
			q = params[:q].split
		else
			q = params[:q]
		end
		@protocols = Protocol.ransack(subject_or_content_cont_any: q).result(distinct: true)
		@discussions = Discussion.ransack(subject_or_content_cont_any: q).result(distinct: true)
		@questions = Question.ransack(subject_or_content_cont_any: q).result(distinct: true)
		@rank_protocols = Protocol.all.order(created_at: "DESC")
		@rank_discussions = Discussion.all.order(created_at: "DESC")
		@rank_questions = Question.all.order(created_at: "DESC")
		@tags = ActsAsTaggableOn::Tag.most_used(5)
	end
	
end
