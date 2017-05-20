class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.is_admin?
      can :manage, :all
    end

    can :manage, Job do |j|
      j.user == user
    end

    cannot :manage, Job do |j|
      user != j.user
    end

    if user.is_auth?
      can [:read], [Job, Application, Connection]
    end

    if user.is_auth == false
      cannot [:read], [Job, Application, Connection]
    end
    #
    # cannot :like, Question do |q|
    #   user == q.user
    # end
    #
    # can :like, Question do |q|
    #   user != q.user
    # end
  end
end
