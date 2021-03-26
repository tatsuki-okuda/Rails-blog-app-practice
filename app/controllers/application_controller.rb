class ApplicationController < ActionController::Base
    # ActionController::Baseにrailsの全てが詰まってる。

    # applicationcontorollerは全てのコントローラーで継承されているので、ここでのbeforeアクションは全てのコントローラーで実行される
    before_action :set_locale

    def current_user
        ActiveDecorator::Decorator.instance.decorate(super) if super.present?
        super
    end

    # applicationContorollerで必ずデフォルトで実行される
    def default_url_options
        { locale: I18n.locale }
    end
    
    private
    def set_locale
        I18n.locale = params[:locale] || I18n.default_locale
    end
    
    
end
