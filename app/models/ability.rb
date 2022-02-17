class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.admin?
      puts "yes logado"
      can :access, :rails_admin       # only allow admin users to access Rails Admin
      can :dashboard           
      can :manage, :all
      puts "not logado"
      can :read, :all                   # allow everyone to read everything
    end
  end
end