# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    can [:reregistration, :reactive], :user
    can [:top, :home, :about, :tags], :static_page
    can :read, Discussion
    can :read, Question
    can :read, Protocol
    can :read, :search
    if user.present?
      can :hide, :user
      can :favorites, :static_page

      can [:create], Discussion
      can [:update, :destroy], Discussion, user_id: user.id
      can [:create, :destroy], DiscussComment, user_id: user.id
      can [:create, :destroy], DiscussFavorite, user_id: user.id

      can [:create], Question
      can [:update, :destroy], Question, user_id: user.id
      can [:create, :destroy], QuesComment, user_id: user.id
      can [:create, :destroy], QuesFavorite, user_id: user.id

      can [:create], Protocol
      can [:update, :destroy], Protocol, user_id: user.id
      can [:create, :destroy], ProtocolFavorite, user_id: user.id

      can [:create], Laboratory
      can [:join, :unjoin], LabMember, laboratory: { lab_members: { user_id: user.id, joined_at: nil } }
      can [:show, :edit], Laboratory, lab_members: { user_id: user.id }
      can [:update], Laboratory, lab_members: { user_id: user.id, status: 2 }
      can :manage, LabMember, laboratory: { lab_members: { user_id: user.id, status: 2 } }
      can :manage, LabTask, laboratory: { lab_members: { user_id: user.id } }

      can :create, Event, laboratory: { lab_members: { user_id: user.id } }
      can :destroy, Event, user_id: user.id

      can :read, LabInformation, laboratory: { lab_members: { user_id: user.id } }
      can [:create, :destroy], LabInformation, laboratory: { lab_members: { user_id: user.id, status: 1 } }
      can [:create, :destroy], LabInformation, laboratory: { lab_members: { user_id: user.id, status: 2 } }

      can [:create], LabInformationCheck, lab_information: { laboratory: { lab_members: { user_id: user.id } } }
      can [:destroy], LabInformationCheck, user_id: user.id

      can [:create], LabInformationComment, lab_information: { laboratory: { lab_members: { user_id: user.id } } }
      can [:destroy], LabInformationComment, user_id: user.id
    end
  end
end
