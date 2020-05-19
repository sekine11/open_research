# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Admin.create!(
	email: "open_research@admin.com",
	password: "123456",
	password_confirmation: "123456"
	)

50.times do

	User.create!(
		email: Faker::Internet.email,
		public_name: Faker::JapaneseMedia::SwordArtOnline.unique.game_name,
		private_name: Faker::JapaneseMedia::SwordArtOnline.unique.real_name,
		image_id: "",
		password: "123456",
    	password_confirmation: "123456"
		)

end

30.times do

	question = Question.create!(
				user_id: rand(1..50),
				subject: "テストテスト#{rand(1..99)}",
				content: "テスト" * 100,
				status: 0,
				impressions_count: rand(1..200)
				)
	question.question_list.add "DNA", "RNA", "NGS", "Protein"
	question.save

end

200.times do

	QuesComment.create!(
		user_id: rand(1..50),
		question_id: rand(1..30),
		content: "テスト" * 20
		)

end

30.times do

	protocol = Protocol.create!(
				user_id: rand(1..50),
				subject: "テストテスト#{rand(1..99)}",
				content: "テスト" * 100,
				impressions_count: rand(1..200)
				)
	protocol.protocol_list.add "DNA", "NGS", "Protein"
	protocol.save

end

30.times do

	discussion = Discussion.create!(
				user_id: rand(1..50),
				subject: "テストテスト#{rand(1..99)}",
				content: "テスト" * 100,
				status: 0,
				impressions_count: rand(1..200)
				)
	discussion.discussion_list.add "DNA", "RNA", "NGS", "Protein"
	discussion.save

end

200.times do

	DiscussComment.create!(
		user_id: rand(1..50),
		discussion_id: rand(1..30),
		content: "テスト" * 20
		)

end