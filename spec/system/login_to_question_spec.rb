require 'rails_helper'

RSpec.describe "Question", type: :system do
  describe '質問関連' do
    context '新規投稿' do
      before do
        create(:user)
        visit new_user_session_path
        fill_in 'user[email]', with: "test@example.com"
        fill_in 'user[password]', with: "password"
        click_button 'ログインする'
        expect(current_path).to eq(home_path)
      end
  	  it '新規投稿できる' do
  	   click_link "質問する"
       fill_in 'question[subject]', with: "RNAが分解される"
       fill_in 'question[content]', with: "あ" * 1000
       check( "question_question_list_enzyme", allow_label_click: true )
       check( "question_question_list_dna", allow_label_click: true )
       check( "question_question_list_rna", allow_label_click: true )
       click_button "質問を投稿"
       expect(page).to have_content '質問を投稿しました'
       expect(page).to have_content 'RNAが分解される'
       expect(page).to have_content 'あ' * 1000
       expect(page).to have_content '太郎'
       visit questions_path
       expect(page).to have_content 'RNAが分解される'
  	  end
      it '新規投稿できない' do
       click_link "質問する"
       fill_in 'question[subject]', with: ""
       fill_in 'question[content]', with: ""
       click_button "質問を投稿"
       expect(page).to have_content 'タグを入力してください'
       expect(page).to have_content '題名を入力してください'
       expect(page).to have_content '内容を入力してください'
      end
    end
    context '編集・削除' do
      before do
        create(:user)
        create(:question)
        visit new_user_session_path
        fill_in 'user[email]', with: "test@example.com"
        fill_in 'user[password]', with: "password"
        click_button 'ログインする'
        expect(current_path).to eq(home_path)
      end
      it '編集できる' do
        visit questions_path
        click_link "テストテスト", match: :first
        click_link "編集"
        fill_in 'question[subject]', with: "RNAが分解される"
        fill_in 'question[content]', with: "あ" * 1000
        check( "question_question_list_enzyme", allow_label_click: true )
        check( "question_question_list_dna", allow_label_click: true )
        check( "question_question_list_rna", allow_label_click: true )
        click_button '質問を編集'
        expect(page).to have_content "質問を編集しました"
        expect(page).to have_content 'RNAが分解される'
        expect(page).to have_content 'あ' * 1000
      end
      it '編集できない' do
        visit questions_path
        click_link "テストテスト", match: :first
        click_link "編集"
        fill_in 'question[subject]', with: ""
        fill_in 'question[content]', with: ""
        uncheck( "question_question_list_dna", allow_label_click: true )
        click_button '質問を編集'
        expect(page).to have_content '題名を入力してください'
        expect(page).to have_content '内容を入力してください'
      end
      it '削除できる' do
        visit questions_path
        click_link "テストテスト", match: :first
        click_link "削除"
        page.driver.browser.switch_to.alert.accept
        expect(current_path).to eq(questions_path)
        expect(page).to have_content '削除しました'
        expect(page).to have_no_content 'テストテスト'
      end
    end
    context 'お気に入り' do
      before do
        create(:user)
        create(:question)
        visit new_user_session_path
        fill_in 'user[email]', with: "test@example.com"
        fill_in 'user[password]', with: "password"
        click_button 'ログインする'
        expect(current_path).to eq(home_path)
      end
      it 'お気に入りできる' do
        visit questions_path
        click_link "テストテスト", match: :first
        find(".favorite-link").find(".fa-heart").click
        visit favorites_path
        expect(page).to have_content('テストテスト', count: 2)
      end
      it 'お気に入りを外せる' do
        visit questions_path
        click_link "テストテスト", match: :first
        find(".favorite-link").find(".fa-heart").click
        visit favorites_path
        expect(page).to have_content('テストテスト', count: 2)
        click_link "テストテスト", match: :first
        find(".favorite-link").find(".fa-heart").click
        visit favorites_path
        expect(page).to have_content('テストテスト', count: 1)
      end
    end
    context 'コメント' do
      before do
        create(:user)
        create(:question)
        visit new_user_session_path
        fill_in 'user[email]', with: "test@example.com"
        fill_in 'user[password]', with: "password"
        click_button 'ログインする'
        expect(current_path).to eq(home_path)
      end
      it 'コメントできる' do
        visit questions_path
        click_link "テストテスト", match: :first
        fill_in 'ques_comment[content]', with: "宜しくお願いします。"
        click_button 'コメント'
        expect(page).to have_content '宜しくお願いします。'
      end
      it 'コメント削除できる' do
        visit questions_path
        click_link "テストテスト", match: :first
        fill_in 'ques_comment[content]', with: "宜しくお願いします。"
        click_button 'コメント'
        expect(page).to have_content '宜しくお願いします。'
        find(".delete-link").find(".fa-trash-alt").click
        expect(page).to have_no_content '宜しくお願いします。'
      end
    end
    context 'ステータス' do
      before do
        create(:user)
        create(:question)
        visit new_user_session_path
        fill_in 'user[email]', with: "test@example.com"
        fill_in 'user[password]', with: "password"
        click_button 'ログインする'
        expect(current_path).to eq(home_path)
      end
      it 'ステータス変更できる' do
        visit questions_path
        click_link "テストテスト", match: :first
        find(".check-link").find(".fa-check").click
        visit questions_path
        expect(page).to have_content '解決済み'
      end
      it 'ステータスを戻せる' do
        visit questions_path
        click_link "テストテスト", match: :first
        find(".check-link").find(".fa-check").click
        visit questions_path
        expect(page).to have_content '解決済み'
        click_link "テストテスト", match: :first
        find(".check-link").find(".fa-check").click
        visit questions_path
        expect(page).to have_content '受付中'
      end
    end
  end
end
