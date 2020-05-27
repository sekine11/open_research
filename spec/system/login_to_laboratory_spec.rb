require 'rails_helper'

RSpec.describe "Laboratory", type: :system do
  describe 'ラボラトリー関連' do
    context '新規作成' do
      before do
        create(:user)
        visit new_user_session_path
        fill_in 'user[email]', with: "test@example.com"
        fill_in 'user[password]', with: "password"
        click_button 'ログインする'
        expect(current_path).to eq(home_path)
      end
  	  it '新規作成できる' do
  	   find("#navbarDropdown1").double_click
       click_link "新しくラボを作る"
       fill_in 'laboratory[name]', with: "東京大学　東京研究室"
       click_button "ラボを作成"
       expect(page).to have_content 'ラボを作成しました'
       expect(page).to have_content '東京大学　東京研究室'
       visit home_path
       find("#navbarDropdown1").double_click
       click_link "東京大学　東京研究室"
  	  end
      it '新規作成できない' do
       find("#navbarDropdown1").double_click
       click_link "新しくラボを作る"
       fill_in 'laboratory[name]', with: ""
       click_button "ラボを作成"
       expect(page).to have_content 'ラボ名を入力してください'
      end
    end
    context '編集' do
      before do
        create(:user)
        create(:laboratory)
        create(:lab_member)
        visit new_user_session_path
        fill_in 'user[email]', with: "test@example.com"
        fill_in 'user[password]', with: "password"
        click_button 'ログインする'
        expect(current_path).to eq(home_path)
      end
      it '編集できる' do
        find("#navbarDropdown1").double_click
        click_link "テスト大学　テスト研究室"
        click_link "ラボ情報編集"
        fill_in 'laboratory[name]', with: "東京大学　東京研究室"
        click_button "編集する"
        click_link "テスト大学　テスト研究室"
        expect(page).to have_content '東京大学　東京研究室'
      end
      it '編集できない' do
        find("#navbarDropdown1").double_click
        click_link "テスト大学　テスト研究室"
        click_link "ラボ情報編集"
        fill_in 'laboratory[name]', with: ""
        click_button "編集する"
        expect(page).to have_content "ラボ名を入力してください"
      end
    end
    context 'ラボタスクの作成' do
      before do
        create(:user)
        create(:laboratory)
        create(:lab_member)
        visit new_user_session_path
        fill_in 'user[email]', with: "test@example.com"
        fill_in 'user[password]', with: "password"
        click_button 'ログインする'
        expect(current_path).to eq(home_path)
      end
      it '作成できる' do
        find("#navbarDropdown1").double_click
        click_link "テスト大学　テスト研究室"
        fill_in 'lab_task[content]', with: "培地の作製"
        click_button "タスクを追加"
        click_link "テスト大学　テスト研究室"
        expect(page).to have_css('#task-1', text: '培地の作製')
      end
      it '作成できない' do
        find("#navbarDropdown1").double_click
        click_link "テスト大学　テスト研究室"
        fill_in 'lab_task[content]', with: ""
        click_button "タスクを追加"
        expect(page).to have_content "内容を入力してください"
      end
    end
    context 'ラボお知らせの作製' do
      before do
        create(:user)
        create(:laboratory)
        create(:lab_member)
        visit new_user_session_path
        fill_in 'user[email]', with: "test@example.com"
        fill_in 'user[password]', with: "password"
        click_button 'ログインする'
        expect(current_path).to eq(home_path)
      end
      it '作成できる' do
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
      it '作成できない' do
        find("#navbarDropdown1").double_click
        click_link "テスト大学　テスト研究室"
        click_link "お知らせを投稿"
        fill_in 'lab_information[subject]', with: ""
        fill_in 'lab_information[content]', with: ""
        click_button "お知らせを投稿"
        expect(page).to have_content "題名を入力してください"
        expect(page).to have_content "内容を入力してください"
      end
      it '削除できる' do
        find("#navbarDropdown1").double_click
        click_link "テスト大学　テスト研究室"
        click_link "お知らせを投稿"
        fill_in 'lab_information[subject]', with: "学会準備について"
        fill_in 'lab_information[content]', with: "あ" * 1000
        click_button "お知らせを投稿"
        expect(page).to have_content "学会準備について"
        expect(page).to have_content "あ" * 1000
        click_link "削除"
        page.driver.browser.switch_to.alert.accept
        expect(page).to have_content 'お知らせを削除しました'
        expect(page).to have_no_content '学会準備について'
      end
    end
    context 'ラボお知らせのコメント' do
      before do
        create(:user)
        create(:laboratory)
        create(:lab_member)
        create(:lab_information)
        visit new_user_session_path
        fill_in 'user[email]', with: "test@example.com"
        fill_in 'user[password]', with: "password"
        click_button 'ログインする'
        expect(current_path).to eq(home_path)
      end
      it 'コメントできる' do
        find("#navbarDropdown1").double_click
        click_link "テスト大学　テスト研究室"
        click_link "お知らせ一覧"
        click_link "テストテスト"
        fill_in 'lab_information_comment[content]', with: "確認しました！"
        click_button 'コメント'
        expect(page).to have_content "確認しました！"
      end
      it 'コメントできない' do
        find("#navbarDropdown1").double_click
        click_link "テスト大学　テスト研究室"
        click_link "お知らせ一覧"
        click_link "テストテスト"
        fill_in 'lab_information_comment[content]', with: ""
        click_button 'コメント'
        expect(page).to have_content "コメントを入力してください"
      end
      it 'コメント削除できる' do
        find("#navbarDropdown1").double_click
        click_link "テスト大学　テスト研究室"
        click_link "お知らせ一覧"
        click_link "テストテスト"
        click_link "テストテスト"
        fill_in 'lab_information_comment[content]', with: "確認しました！"
        click_button 'コメント'
        expect(page).to have_content "確認しました！"
        find('.delete-comment').find('.fa-trash-alt').click
        expect(page).to have_no_content "確認しました！"
      end
      it 'checkできる' do
        find("#navbarDropdown1").double_click
        click_link "テスト大学　テスト研究室"
        click_link "お知らせ一覧"
        click_link "テストテスト"
        click_link "テストテスト"
        find('.check-button').find('.fa-check').click
        expect(page).to have_css('#checks-count', text: '1')
      end
      it 'checkを戻せる' do
        find("#navbarDropdown1").double_click
        click_link "テスト大学　テスト研究室"
        click_link "お知らせ一覧"
        click_link "テストテスト"
        click_link "テストテスト"
        find('.check-button').find('.fa-check').click
        expect(page).to have_css('#checks-count', text: '1')
        find('.check-button').find('.fa-check').click
        expect(page).to have_css('#checks-count', text: '0')
      end
    end
    context 'ラボ予定の投稿' do
      before do
        create(:user)
        create(:laboratory)
        create(:lab_member)
        visit new_user_session_path
        fill_in 'user[email]', with: "test@example.com"
        fill_in 'user[password]', with: "password"
        click_button 'ログインする'
        expect(current_path).to eq(home_path)
      end
      it '予定投稿できる' do
        find("#navbarDropdown1").double_click
        click_link "テスト大学　テスト研究室"
        click_button "予定を登録"
        fill_in 'event[start]', with: "2020/05/13 19:47"
        fill_in 'event[end]', with: "2020/05/14 19:47"
        fill_in 'event[title]', with: "会議"
        click_button '予定を作成'
        expect(page).to have_content "会議 テスト太郎"
      end
      it '予定投稿できない' do
        find("#navbarDropdown1").double_click
        click_link "テスト大学　テスト研究室"
        click_button "予定を登録"
        fill_in 'event[start]', with: ""
        fill_in 'event[end]', with: ""
        fill_in 'event[title]', with: ""
        click_button '予定を作成'
        click_button "予定を登録"
        expect(page).to have_content "タイトルを入力してください"
        expect(page).to have_content "開始時刻を入力してください"
        expect(page).to have_content "終了時刻を入力してください"
      end
      it 'イベント削除できる' do
        find("#navbarDropdown1").double_click
        click_link "テスト大学　テスト研究室"
        click_button "予定を登録"
        fill_in 'event[start]', with: "2020/05/13 19:47"
        fill_in 'event[end]', with: "2020/05/14 19:47"
        fill_in 'event[title]', with: "会議"
        click_button '予定を作成'
        expect(page).to have_content "会議 テスト太郎"
        find(".fc-content").click
        click_link "削除"
        expect(page).to have_no_content "会議 テスト太郎"
      end
    end
  end
end
