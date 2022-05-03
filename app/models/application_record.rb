class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  # Decorate object with appropriate decorator
  def decorate
    self.class.decorator_class.new(self)
  end

  # Decorate collection with appropriate decorator
  def self.decorate
    decorator_class.decorate_collection(all)
  end

  # Infers the decorator class to be used by (e.g. `User` maps to `UserDecorator`).
  # adapted from https://github.com/drapergem/draper/blob/157eb955072a941e6455e0121fca09a989fcbc21/lib/draper/decoratable.rb#L71
  def self.decorator_class(called_on = self)
    prefix = respond_to?(:model_name) ? model_name : name
    decorator_name = "#{prefix}Decorator"
    decorator_name_constant = decorator_name.safe_constantize
    return decorator_name_constant unless decorator_name_constant.nil?

    return superclass.decorator_class(called_on) if superclass.respond_to?(:decorator_class)

    raise DecoratorNotFoundError, "#{called_on.class.name}의 데코레이터를 찾을 수 없습니다."
  end
end
