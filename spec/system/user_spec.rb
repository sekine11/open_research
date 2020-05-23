require 'rails_helper'

RSpec.describe "User", type: :system do
  describe 'ユーザー関連' do
    context '会員登録' do
  	  it '新規登録・ログインできる' do
  	    visit new_user_registration_path
  	    fill_in 'user[public_name]', with: "フジ"
  	    fill_in 'user[private_name]', with: "藤本浩太"
  	    fill_in 'user[email]', with: "fuji@gmail.com"
  	    fill_in 'user[password]', with: "password"
  	    fill_in 'user[password_confirmation]', with: "password"
  	    expect { click_button '登録する' }.to change { ActionMailer::Base.deliveries.size }.by(1)
  	    expect(current_path).to eq(root_path)
  	    expect(page).to have_content '本人確認用のメールを送信しました。メール内のリンクからアカウントを有効化させてください。'
        mail = ActionMailer::Base.deliveries.last
        url = mail.body.encoded[/http[^"]+/]
  	    visit url
  	    expect(current_path).to eq(new_user_session_path)
  	    expect(page).to have_content 'アカウントを登録しました。'
  	    fill_in 'user[email]', with: "fuji@gmail.com"
  	    fill_in 'user[password]', with: "password"
  	    click_button 'ログインする'
  	    expect(current_path).to eq(home_path)
  	    expect(page).to have_content 'ログインしました'
  	  end
      it '新規登録・ログインできない' do
        visit new_user_registration_path
        fill_in 'user[public_name]', with: ""
        fill_in 'user[private_name]', with: ""
        fill_in 'user[email]', with: ""
        fill_in 'user[password]', with: ""
        fill_in 'user[password_confirmation]', with: ""
        click_button '登録する'
        expect(page).to have_content '公開される名前を入力してください'
        expect(page).to have_content '公開されない名前を入力してください'
        expect(page).to have_content 'メールアドレスを入力してください'
        expect(page).to have_content 'パスワードを入力してください'
      end
    end
    context '会員情報編集' do
      before do
        @user = create(:user)
      end
      it 'ログイン後にprivate_nameとpublic_nameの更新ができる' do
        visit new_user_session_path
        fill_in 'user[email]', with: @user.email
        fill_in 'user[password]', with: "password"
        click_button 'ログインする'
        expect(current_path).to eq(home_path)
        click_link "会員情報"
        fill_in 'user[public_name]', with: "フジ"
        fill_in 'user[private_name]', with: "藤本浩太"
        click_button "更新する"
        expect(current_path).to eq(edit_user_registration_path)
        expect(page).to have_content 'アカウント情報を変更しました'
        expect(page).to have_content 'フジ'
        expect(page).to have_content '藤本浩太'
      end
      it 'ログイン後にemailの更新ができる' do
        visit new_user_session_path
        fill_in 'user[email]', with: @user.email
        fill_in 'user[password]', with: "password"
        click_button 'ログインする'
        expect(current_path).to eq(home_path)
        click_link "会員情報"
        fill_in 'user[email]', with: "sample@test.com"
        click_button "更新する"
        expect(page).to have_content 'アカウント情報を変更しました。変更されたメールアドレスの本人確認のため、本人確認用メールより確認処理をおこなってください。'
        mail = ActionMailer::Base.deliveries.last
        url = mail.body.encoded[/http[^"]+/]
        visit url
        expect(current_path).to eq(root_path)
        expect(page).to have_content 'アカウントを登録しました。'
        click_link "会員情報"
        expect(page).to have_content 'sample@test.com'
      end
      it 'ログイン後にpasswordの更新ができる' do
        visit new_user_session_path
        fill_in 'user[email]', with: @user.email
        fill_in 'user[password]', with: "password"
        click_button 'ログインする'
        expect(current_path).to eq(home_path)
        click_link "会員情報"
        fill_in 'user[password]', with: "hogehoge"
        fill_in 'user[password_confirmation]', with: "hogehoge"
        click_button "更新する"
        expect(current_path).to eq(edit_user_registration_path)
        click_link 'ログアウト'
        visit new_user_session_path
        fill_in 'user[email]', with: @user.email
        fill_in 'user[password]', with: "hogehoge"
        click_button 'ログインする'
        expect(current_path).to eq(home_path)
      end
      it 'ログイン後にpasswordの更新ができない' do
        visit new_user_session_path
        fill_in 'user[email]', with: @user.email
        fill_in 'user[password]', with: "password"
        click_button 'ログインする'
        expect(current_path).to eq(home_path)
        click_link "会員情報"
        fill_in 'user[public_name]', with: ""
        fill_in 'user[private_name]', with: ""
        fill_in 'user[email]', with: ""
        click_button "更新する"
        expect(page).to have_content '公開される名前を入力してください'
        expect(page).to have_content '公開されない名前を入力してください'
        expect(page).to have_content 'メールアドレスを入力してください'
      end
    end
  end
end
