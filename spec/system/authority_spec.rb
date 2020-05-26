require 'rails_helper'

RSpec.describe "Authority", type: :system do
  describe 'アクセス権限' do
    context '非ログインユーザー' do
      before do
        create(:user)
        @question = create(:question)
        @discussion = create(:discussion)
        @protocol = create(:protocol)
      end
  	  it 'ホームにアクセス可' do
  	    visit home_path
        expect(current_path).to eq(home_path)
  	  end
      it 'アバウトにアクセス可' do
        visit about_path
        expect(current_path).to eq(about_path)
      end
      it '質問一覧にアクセス可' do
        visit questions_path
        expect(current_path).to eq(questions_path)
      end
      it '議論一覧にアクセス可' do
        visit discussions_path
        expect(current_path).to eq(discussions_path)
      end
      it 'プロトコル一覧にアクセス可' do
        visit protocols_path
        expect(current_path).to eq(protocols_path)
      end
      it 'ログイン画面にアクセス可' do
        visit new_user_session_path
        expect(current_path).to eq(new_user_session_path)
      end
      it '新規登録画面にアクセス可' do
        visit new_user_registration_path
        expect(current_path).to eq(new_user_registration_path)
      end
      it '検索にアクセス可' do
        visit search_path
        expect(current_path).to eq(search_path)
      end
      it 'タグにアクセス可' do
        visit tags_path(tag: "DNA")
        expect(current_path).to eq(tags_path)
      end
      it 'お問い合わせにアクセス可' do
        visit new_contact_path
        expect(current_path).to eq(new_contact_path)
      end
      it '質問詳細にアクセス可' do
        visit question_path(@question)
        expect(current_path).to eq(question_path(@question))
      end
      it '議論詳細にアクセス可' do
        visit discussion_path(@discussion)
        expect(current_path).to eq(discussion_path(@discussion))
      end
      it 'プロトコル詳細にアクセス可' do
        visit protocol_path(@protocol)
        expect(current_path).to eq(protocol_path(@protocol))
      end
      it '質問詳細にコメント不可' do
        visit question_path(@question)
        fill_in "ques_comment[content]", with: "宜しくお願いします。"
        click_button "コメント"
        expect(page).to have_content "新規登録もしくは、ログインしてください。"
      end
      it '議論詳細にコメント不可' do
        visit discussion_path(@discussion)
        fill_in "discuss_comment[content]", with: "宜しくお願いします。"
        click_button "コメント"
        expect(page).to have_content "新規登録もしくは、ログインしてください。"
      end
    end
    context 'ログインユーザー：ラボアドミン' do
      before do
        create(:user)
        @laboratory = create(:laboratory)
        create(:lab_member)
        visit new_user_session_path
        fill_in 'user[email]', with: "test@example.com"
        fill_in 'user[password]', with: "password"
        click_button 'ログインする'
      end
      it 'ラボにアクセス可' do
        find("#navbarDropdown1").double_click
        click_link "テスト大学　テスト研究室"
        expect(current_path).to eq(laboratory_path(@laboratory))
      end
      it 'ラボ名編集可' do
        find("#navbarDropdown1").double_click
        click_link "テスト大学　テスト研究室"
        click_link "ラボ情報編集"
        fill_in 'laboratory[name]', with: "東京大学　東京研究室"
        click_button "編集する"
        click_link "テスト大学　テスト研究室"
        expect(page).to have_content '東京大学　東京研究室'
      end
      it 'ラボメンバーステータス編集可' do
        find("#navbarDropdown1").double_click
        click_link "テスト大学　テスト研究室"
        click_link "ラボ情報編集"
        find('#list-edit-list').click
        find(".member").find(".fa-user-friends").click
        expect(page).to have_content('メンバー', count: 2)
      end
      it 'ラボメンバーステータス編集可' do
        find("#navbarDropdown1").double_click
        click_link "テスト大学　テスト研究室"
        click_link "ラボ情報編集"
        find('#list-edit-list').click
        find(".subadmin").find(".fa-users-cog").click
        expect(page).to have_content('副管理者', count: 1)
      end
      it 'ラボお知らせ投稿可' do
        find("#navbarDropdown1").double_click
        click_link "テスト大学　テスト研究室"
        click_link "お知らせを投稿"
        fill_in 'lab_information[subject]', with: "学会準備について"
        fill_in 'lab_information[content]', with: "あ" * 1000
        click_button "お知らせを投稿"
        expect(page).to have_content "学会準備について"
        expect(page).to have_content "あ" * 1000
        click_link "お知らせ一覧"
        expect(page).to have_content "学会準備について"
      end
    end
    context 'ログインユーザー：ラボサブアドミン' do
      before do
        create(:user)
        @laboratory = create(:laboratory)
        create(:subadmin_member)
        visit new_user_session_path
        fill_in 'user[email]', with: "test@example.com"
        fill_in 'user[password]', with: "password"
        click_button 'ログインする'
      end
      it 'ラボにアクセス可' do
        find("#navbarDropdown1").double_click
        click_link "テスト大学　テスト研究室"
        expect(current_path).to eq(laboratory_path(@laboratory))
      end
      it 'ラボ名編集不可' do
        find("#navbarDropdown1").double_click
        click_link "テスト大学　テスト研究室"
        click_link "ラボ情報編集"
        fill_in 'laboratory[name]', with: "東京大学　東京研究室"
        click_button "編集する"
        expect(page).to have_content 'ラボのメンバーではないか、権限をもっていません'
      end
      it 'ラボメンバーステータス編集不可' do
        find("#navbarDropdown1").double_click
        click_link "テスト大学　テスト研究室"
        click_link "ラボ情報編集"
        find('#list-edit-list').click
        expect(page).to have_content('管理者のみ操作可能です。')
      end
      it 'ラボお知らせ投稿可' do
        find("#navbarDropdown1").double_click
        click_link "テスト大学　テスト研究室"
        click_link "お知らせを投稿"
        fill_in 'lab_information[subject]', with: "学会準備について"
        fill_in 'lab_information[content]', with: "あ" * 1000
        click_button "お知らせを投稿"
        expect(page).to have_content "学会準備について"
        expect(page).to have_content "あ" * 1000
        click_link "お知らせ一覧"
        expect(page).to have_content "学会準備について"
      end
    end
    context 'ログインユーザー：ラボメンバー' do
      before do
        create(:user)
        @laboratory = create(:laboratory)
        create(:member_member)
        visit new_user_session_path
        fill_in 'user[email]', with: "test@example.com"
        fill_in 'user[password]', with: "password"
        click_button 'ログインする'
      end
      it 'ラボにアクセス可' do
        find("#navbarDropdown1").double_click
        click_link "テスト大学　テスト研究室"
        expect(current_path).to eq(laboratory_path(@laboratory))
      end
      it 'ラボ名編集不可' do
        find("#navbarDropdown1").double_click
        click_link "テスト大学　テスト研究室"
        click_link "ラボ情報編集"
        expect(page).to have_no_content '編集する'
      end
      it 'ラボメンバーステータス編集不可' do
        find("#navbarDropdown1").double_click
        click_link "テスト大学　テスト研究室"
        click_link "ラボ情報編集"
        find('#list-edit-list').click
        expect(page).to have_content('管理者のみ操作可能です。')
      end
      it 'ラボお知らせ投稿不可' do
        find("#navbarDropdown1").double_click
        click_link "テスト大学　テスト研究室"
        click_link "お知らせを投稿"
        expect(page).to have_content "ラボのメンバーではないか、権限をもっていません"
      end
    end
  end
end
