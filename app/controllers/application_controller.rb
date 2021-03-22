class ApplicationController < ActionController::Base
    # ActionController::Baseにrailsの全てが詰まってる。

    def current_user
        ActiveDecorator::Decorator.instance.decorate(super) if super.present?
        super
    end
    
end
