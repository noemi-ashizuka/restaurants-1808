class RestaurantPolicy < ApplicationPolicy
  # NOTE: Up to Pundit v2.3.1, the inheritance was declared as
  # `Scope < Scope` rather than `Scope < ApplicationPolicy::Scope`.
  # In most cases the behavior will be identical, but if updating existing
  # code, beware of possible changes to the ancestors:
  # https://gist.github.com/Burgestrand/4b4bc22f31c8a95c425fc0e30d7ef1f5

  class Scope < ApplicationPolicy::Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      # scope.all.order(created_at: :desc)
      if user
        user.admin? ? scope.all : scope.where(user: user)
      else
        scope.all
      end
    end
  end

  def show?
    true
  end

  def new?
    create?
  end

  def create?
    user
  end

  def edit?
    update?
  end

  def update?
    # only the owner of the restaurant is allowed to update
    record.user == user || user.admin?
  end

  def destroy?
    # only the owner of the restaurant is allowed to destroy it
    record.user == user
  end
end
