require 'rails_helper'

RSpec.describe "Disccussion", type: :system do
  describe '議論関連' do
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
  	   click_link "議論を開始"
       fill_in 'discussion[subject]', with: "競争的資金の処理について"
       fill_in 'discussion[content]', with: "あ" * 1000
       check( "discussion_discussion_list_enzyme", allow_label_click: true )
       check( "discussion_discussion_list_dna", allow_label_click: true )
       check( "discussion_discussion_list_rna", allow_label_click: true )
       click_button "議論を開始"
       expect(page).to have_content '議論を開始しました'
       expect(page).to have_content '競争的資金の処理について'
       expect(page).to have_content 'あ' * 1000
       expect(page).to have_content '太郎'
       visit discussions_path
       expect(page).to have_content '競争的資金の処理について'
  	  end
      it '新規投稿できない' do
       click_link "議論を開始"
       fill_in 'discussion[subject]', with: ""
       fill_in 'discussion[content]', with: ""
       click_button "議論を開始"
       expect(page).to have_content 'タグを入力してください'
       expect(page).to have_content '題名を入力してください'
       expect(page).to have_content '内容を入力してください'
      end
    end
    context '編集・削除' do
      before do
        create(:user)
        create(:discussion)
        visit new_user_session_path
        fill_in 'user[email]', with: "test@example.com"
        fill_in 'user[password]', with: "password"
        click_button 'ログインする'
        expect(current_path).to eq(home_path)
      end
      it '編集できる' do
        visit discussions_path
        click_link "テストテスト", match: :first
        click_link "編集"
        fill_in 'discussion[subject]', with: "競争的資金の処理について"
        fill_in 'discussion[content]', with: "あ" * 1000
        check( "discussion_discussion_list_enzyme", allow_label_click: true )
        check( "discussion_discussion_list_dna", allow_label_click: true )
        check( "discussion_discussion_list_rna", allow_label_click: true )
        click_button '議論を編集'
        expect(page).to have_content "議論を編集しました"
        expect(page).to have_content '競争的資金の処理について'
        expect(page).to have_content 'あ' * 1000
      end
      it '編集できない' do
        visit discussions_path
        click_link "テストテスト", match: :first
        click_link "編集"
        fill_in 'discussion[subject]', with: ""
        fill_in 'discussion[content]', with: ""
        uncheck( "discussion_discussion_list_dna", allow_label_click: true )
        click_button '議論を編集'
        expect(page).to have_content '題名を入力してください'
        expect(page).to have_content '内容を入力してください'
      end
      it '削除できる' do
        visit discussions_path
        click_link "テストテスト", match: :first
        click_link "削除"
        page.driver.browser.switch_to.alert.accept
        expect(current_path).to eq(discussions_path)
        expect(page).to have_content '削除しました'
        expect(page).to have_no_content 'テストテスト'
      end
    end
    context 'お気に入り' do
      before do
        create(:user)
        create(:discussion)
        visit new_user_session_path
        fill_in 'user[email]', with: "test@example.com"
        fill_in 'user[password]', with: "password"
        click_button 'ログインする'
        expect(current_path).to eq(home_path)
      end
      it 'お気に入りできる' do
        visit discussions_path
        click_link "テストテスト", match: :first
        find(".favorite-link").find(".fa-heart").click
        visit favorites_path
        find("#discussions-tab").click
        expect(page).to have_content('テストテスト', count: 2)
      end
      it 'お気に入りを外せる' do
        visit discussions_path
        click_link "テストテスト", match: :first
        find(".favorite-link").find(".fa-heart").click
        visit favorites_path
        find("#discussions-tab").click
        expect(page).to have_content('テストテスト', count: 2)
        click_link "テストテスト", match: :first
        find(".favorite-link").find(".fa-heart").click
        visit favorites_path
        find("#discussions-tab").click
        expect(page).to have_content('テストテスト', count: 1)
      end
    end
    context 'コメント' do
      before do
        create(:user)
        create(:discussion)
        visit new_user_session_path
        fill_in 'user[email]', with: "test@example.com"
        fill_in 'user[password]', with: "password"
        click_button 'ログインする'
        expect(current_path).to eq(home_path)
      end
      it 'コメントできる' do
        visit discussions_path
        click_link "テストテスト", match: :first
        fill_in 'discuss_comment[content]', with: "宜しくお願いします。"
        click_button 'コメント'
        visit discussions_path
        click_link "テストテスト", match: :first
        expect(page).to have_content '宜しくお願いします。'
      end
      it 'コメント削除できる' do
        visit discussions_path
        click_link "テストテスト", match: :first
        fill_in 'discuss_comment[content]', with: "宜しくお願いします。"
        click_button 'コメント'
        visit discussions_path
        click_link "テストテスト", match: :first
        expect(page).to have_content '宜しくお願いします。'
        find(".delete-link").find(".fa-trash-alt").click
        expect(page).to have_no_content '宜しくお願いします。'
      end
    end
    context 'ステータス' do
      before do
        create(:user)
        create(:discussion)
        visit new_user_session_path
        fill_in 'user[email]', with: "test@example.com"
        fill_in 'user[password]', with: "password"
        click_button 'ログインする'
        expect(current_path).to eq(home_path)
      end
      it 'ステータス変更できる' do
        visit discussions_path
        click_link "テストテスト", match: :first
        find(".check-link").find(".fa-check").click
        visit discussions_path
        expect(page).to have_content '終了'
      end
      it 'ステータスを戻せる' do
        visit discussions_path
        click_link "テストテスト", match: :first
        find(".check-link").find(".fa-check").click
        visit discussions_path
        expect(page).to have_content '終了'
        click_link "テストテスト", match: :first
        find(".check-link").find(".fa-check").click
        visit discussions_path
        expect(page).to have_content '活動中'
      end
    end
  end
end
