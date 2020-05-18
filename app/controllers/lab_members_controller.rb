class LabMembersController < ApplicationController
  load_and_authorize_resource :laboratory
  load_and_authorize_resource :lab_member, through: :laboratory
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to home_url, alert: "ラボのメンバーではないか、権限をもっていません"
  end

  def create
    @laboratory = Laboratory.find(params[:laboratory_id])
    if user = User.find_by(email: params[:email])
      @lab_member = LabMember.create(laboratory_id: @laboratory.id, user_id: user.id)
      @lab_members = @laboratory.lab_members
    else
      flash[:alert] = "ユーザーの登録に失敗しました"
      @lab_members = @laboratory.lab_members
    end
  end

  def update
    @laboratory = Laboratory.find(params[:laboratory_id])
    @lab_member = LabMember.find(params[:id])
    @lab_member.update(status: params[:status])
  end

  def destroy
    @laboratory = Laboratory.find(params[:laboratory_id])
    @lab_member = LabMember.find(params[:id])
    @lab_member.destroy
    @lab_members = @laboratory.lab_members
  end
end
