class LabMembersController < ApplicationController
  load_and_authorize_resource :laboratory
  load_and_authorize_resource :lab_member, through: :laboratory
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to home_url, alert: "ラボのメンバーではないか、権限をもっていません"
  end

  def create
    laboratory = Laboratory.find(params[:laboratory_id])
    user = User.find_by(email: params[:email])
    lab_member = LabMember.create(laboratory_id: laboratory.id, user_id: user.id)
    redirect_to edit_laboratory_path(laboratory)
  end

  def update
    laboratory = Laboratory.find(params[:laboratory_id])
    lab_member = LabMember.find(params[:id])
    lab_member.update(status: params[:status])
    redirect_to edit_laboratory_path(laboratory)
  end

  def destroy
    laboratory = Laboratory.find(params[:laboratory_id])
    lab_member = LabMember.find(params[:id])
    lab_member.destroy
    redirect_to edit_laboratory_path(laboratory)
  end
end
