class ContactsController < ApplicationController
  def new
  	@contact = Contact.new
  end

  def create
  	@contact = Contact.new(contact_params)
  	if @contact.save
  		ContactMailer.contact_mail(@contact).deliver
  		redirect_to home_path, notice: "お問い合わせを受け付けました。24時間以内に回答を送信致します。"
  	else
  		render "new"
  	end
  end

  private
  def contact_params
  	params.require(:contact).permit(:title, :email, :message)
  end
end
