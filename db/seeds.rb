# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

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

10.times do

	question = Question.create!(
				user_id: rand(1..50),
				subject: "テスト#{rand(1..99)}",
				content: "テスト" * 100,
				status: 0
				)
	question.question_list.add "DNA", "RNA", "NGS", "Protein"
	question.save

end

50.times do

	QuesComment.create!(
		user_id: rand(1..50),
		question_id: rand(1..10),
		comment: "テスト" * 20
		)

end

10.times do

	protocol = Protocol.create!(
				user_id: rand(1..50),
				subject: "テスト#{rand(1..99)}",
				content: "テスト" * 100
				)
	protocol.protocol_list.add "DNA", "NGS", "Protein"
	protocol.save

end

10.times do

	Laboratory.create!(
		name: "テスト大学テスト研究室#{rand(1..99)}"
		)

end

50.times do

	LabTask.create!(
		user_id: rand(1..50),
		laboratory_id: rand(1..20),
		content: "テストタスク#{rand(1..99)}",
		status: rand(0..2)
		)

end

200.times do

	LabMember.create!(
		user_id: rand(1..50),
		laboratory_id: rand(1..20),
		status: rand(0..3)
		)

end

50.times do

	LabInformation.create!(
		user_id: rand(1..50),
		laboratory_id: rand(1..20),
		subject: "テスト#{rand(1..99)}",
		content: "テスト" * 50
		)

end

200.times do

	LabInformationComment.create!(
		user_id: rand(1..50),
		lab_information_id: rand(1..50),
		content: "テスト" * 50
		)

end

10.times do

	discussion = Discussion.create!(
				user_id: rand(1..50),
				subject: "テスト#{rand(1..99)}",
				content: "テスト" * 100,
				status: 0
				)
	discussion.discussion_list.add "DNA", "RNA", "NGS", "Protein"
	discussion.save

end

50.times do

	DiscussComment.create!(
		user_id: rand(1..50),
		discussion_id: rand(1..10),
		content: "テスト" * 20
		)

end

20.times do

	Project.create!(
		user_id: rand(1..50),
		laboratory_id: rand(1..10),
		name: "テストプロジェクト#{rand(1..99)}"
		)

end

50.times do

	ProjectTask.create!(
		user_id: rand(1..50),
		project_id: rand(1..20),
		content: "テストタスク#{rand(1..99)}",
		status: rand(0..2)
		)

end

50.times do

	ProjectMember.create!(
		user_id: rand(1..50),
		project_id: rand(1..20),
		status: rand(0..3)
		)

end

50.times do

	ProjectInformation.create!(
		user_id: rand(1..50),
		project_id: rand(1..20),
		subject: "テスト#{rand(1..99)}",
		content: "テスト" * 50
		)

end

200.times do

	ProjectInformationComment.create!(
		user_id: rand(1..50),
		project_information_id: rand(1..50),
		content: "テスト" * 50
		)

end


