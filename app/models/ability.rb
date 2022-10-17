# frozen_string_literal: true
# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the user here. For example:
    #
    #   return unless user.present?
    #   can :read, :all
    #   return unless user.admin?
    can :read, Course
    # return unless user.member?

    # can(%i[enroll read mark_as], :all) if user.member?
    can(%i[enroll read mark_as], :all)
    can(:update, Course, superuser_id: user.id)
    can(%i[read], :ProfilesController)
    cannot(%i[index], :ProfilesController)
    if user.superuser?

      can(%i[enroll read mark_as], :all)
      can(:update, Course, superuser_id: user.id)
      can(%i[read], :ProfilesController)
      cannot(%i[index], :ProfilesController)

    elsif user.admin?
      can(:manage, Course, user_id: user.id)

      can(:manage, :ProfilesController)

    end
  end
end
