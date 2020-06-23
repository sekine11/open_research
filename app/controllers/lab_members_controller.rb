class LabMembersController < ApplicationController
  load_and_authorize_resource :laboratory
  load_and_authorize_resource :lab_member, through: :laboratory
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to home_url, alert: "ラボのメンバーではないか、権限をもっていません"
  end

  def create
    @laboratory = Laboratory.find(params[:laboratory_id])
    # emailでのユーザー検索
    user = User.where(email: params[:email])
    if user.present?
      @lab_member = LabMember.create(laboratory_id: @laboratory.id, user_id: user.first.id)
      redirect_to edit_laboratory_path(@laboratory), notice: "メンバーを招待しました。"
    else
      redirect_to edit_laboratory_path(@laboratory), alert: "メンバーの招待に失敗しました。"
    end
  end

  def join
    @lab_member = current_user.lab_members.find_by(laboratory_id: params[:laboratory_id])
    if @lab_member.joined_at == nil
      @lab_member.update(joined_at: Time.now)
      redirect_to home_path, notice: "ラボに参加しました。"
    else
      redirect_to home_path, notice: "すでにラボに参加しています。"
    end
  end

  def unjoin
    @lab_member = current_user.lab_members.find_by(laboratory_id: params[:laboratory_id])
    if @lab_member.joined_at == nil
      @lab_member.destroy
      redirect_to home_path, notice: "ラボへの招待を断りました。"
    else
      redirect_to home_path, notice: "すでにラボに参加しています。"
    end
  end

  def update
    @laboratory = Laboratory.find(params[:laboratory_id])
    @lab_member = LabMember.find(params[:id])
    # ラボ作成者は管理者のままにする
    if @lab_member.user.id != @laboratory.user.id
      @lab_member.update(status: params[:status])
    else
      redirect_to laboratory_path(@laboratory), alert: "ラボ作成者は必ず管理者である必要があります。"
    end
  end

  def destroy
    @laboratory = Laboratory.find(params[:laboratory_id])
    @lab_member = LabMember.find(params[:id])
    @lab_member.destroy
    @lab_members = @laboratory.lab_members
  end
end
