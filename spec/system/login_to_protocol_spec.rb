require 'rails_helper'

RSpec.describe "Protocol", type: :system do
  describe '議論関連' do
    context '新規共有' do
      before do
        create(:user)
        visit new_user_session_path
        fill_in 'user[email]', with: "test@example.com"
        fill_in 'user[password]', with: "password"
        click_button 'ログインする'
        expect(current_path).to eq(home_path)
      end
  	  it '新規共有できる' do
  	   click_link "共有する"
       fill_in 'protocol[subject]', with: "DNAミニプレップ"
       fill_in 'protocol[content]', with: "あ" * 1000
       check( "protocol_protocol_list_enzyme", allow_label_click: true )
       check( "protocol_protocol_list_dna", allow_label_click: true )
       check( "protocol_protocol_list_rna", allow_label_click: true )
       click_button "プロトコルを共有"
       expect(page).to have_content 'プロトコルを共有しました'
       expect(page).to have_content 'DNAミニプレップ'
       expect(page).to have_content 'あ' * 1000
       expect(page).to have_content '太郎'
       visit protocols_path
       expect(page).to have_content 'DNAミニプレップ'
  	  end
      it '新規投稿できない' do
       click_link "共有する"
       fill_in 'protocol[subject]', with: ""
       fill_in 'protocol[content]', with: ""
       click_button "プロトコルを共有"
       expect(page).to have_content 'タグを入力してください'
       expect(page).to have_content '題名を入力してください'
       expect(page).to have_content '内容を入力してください'
      end
    end
    context '編集・削除' do
      before do
        create(:user)
        create(:protocol)
        visit new_user_session_path
        fill_in 'user[email]', with: "test@example.com"
        fill_in 'user[password]', with: "password"
        click_button 'ログインする'
        expect(current_path).to eq(home_path)
      end
      it '編集できる' do
        visit protocols_path
        click_link "テストテスト", match: :first
        click_link "編集"
        fill_in 'protocol[subject]', with: "RNAミニプレップ"
        fill_in 'protocol[content]', with: "あ" * 1000
        check( "protocol_protocol_list_enzyme", allow_label_click: true )
        check( "protocol_protocol_list_dna", allow_label_click: true )
        check( "protocol_protocol_list_rna", allow_label_click: true )
        click_button 'プロトコルを編集'
        expect(page).to have_content "プロトコルを編集しました"
        expect(page).to have_content 'RNAミニプレップ'
        expect(page).to have_content 'あ' * 1000
      end
      it '編集できない' do
        visit protocols_path
        click_link "テストテスト", match: :first
        click_link "編集"
        fill_in 'protocol[subject]', with: ""
        fill_in 'protocol[content]', with: ""
        uncheck( "protocol_protocol_list_dna", allow_label_click: true )
        click_button 'プロトコルを編集'
        expect(page).to have_content '題名を入力してください'
        expect(page).to have_content '内容を入力してください'
      end
      it '削除できる' do
        visit protocols_path
        click_link "テストテスト", match: :first
        click_link "削除"
        page.driver.browser.switch_to.alert.accept
        expect(current_path).to eq(protocols_path)
        expect(page).to have_content '削除しました'
        expect(page).to have_no_content 'テストテスト'
      end
    end
    context 'お気に入り' do
      before do
        create(:user)
        create(:protocol)
        visit new_user_session_path
        fill_in 'user[email]', with: "test@example.com"
        fill_in 'user[password]', with: "password"
        click_button 'ログインする'
        expect(current_path).to eq(home_path)
      end
      it 'お気に入りできる' do
        visit protocols_path
        click_link "テストテスト", match: :first
        find(".favorite-link").find(".fa-heart").click
        visit favorites_path
        find("#protocols-tab").click
        expect(page).to have_content('テストテスト', count: 2)
      end
      it 'お気に入りを外せる' do
        visit protocols_path
        click_link "テストテスト", match: :first
        find(".favorite-link").find(".fa-heart").click
        visit favorites_path
        find("#protocols-tab").click
        expect(page).to have_content('テストテスト', count: 2)
        click_link "テストテスト", match: :first
        find(".favorite-link").find(".fa-heart").click
        visit favorites_path
        find("#protocols-tab").click
        expect(page).to have_content('テストテスト', count: 1)
      end
    end
  end
end
