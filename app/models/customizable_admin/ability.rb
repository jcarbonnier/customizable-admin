module CustomizableAdmin
  class Ability
    include CanCan::Ability

    def initialize(user)

      # Define abilities for the passed in user here. For example:
      user ||= Settings::User.new # guest user (not logged in)
      if (user.has_role?(Settings::Role.super_admin.first))
        can :manage, :all
      else
        Rails.logger.debug(user.all_permissions.to_yaml)
        user.all_permissions.each do |permission|
          if (permission.subject_id.nil?)
            can permission.action.to_sym, (permission.subject_class.safe_constantize.nil?) ?
                                            permission.subject_class.to_sym :
                                            permission.subject_class.safe_constantize
          else
            can permission.action.to_sym, permission.subject_class.constantize, :id => permission.subject_id
          end
        end
        # if (user.has_role?(Role.super_admin.first))
        #   can :manage, :all
        # elsif (user.has_role?(Role.admin.first))
        #   can :manage, Role
        # elsif (user.has_role?(Role.technic.first))
        #   can :manage, Role
        # elsif (user.has_role?(Role.marketing.first))
        #   can :manage, Role
        # elsif (user.has_role?(Role.commercial.first))
        #   can :manage, Role
      end

      # The first argument to `can` is the action you are giving the user
      # permission to do.
      # If you pass :manage it will apply to every action. Other common actions
      # here are :read, :create, :update and :destroy.
      #
      # The second argument is the resource the user can perform the action on.
      # If you pass :all it will apply to every resource. Otherwise pass a Ruby
      # class of the resource.
      #
      # The third argument is an optional hash of conditions to further filter the
      # objects.
      # For example, here the user can only update published articles.
      #
      #   can :update, Article, :published => true
      #
      # See the wiki for details:
      # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
    end
  end
end