require 'render_as_js/view_helpers'
module RenderToJs
  class Railtie < Rails::Railtie
    initializer "render_as_js.view_helpers" do
      ActionView::Base.send :include, RenderToJs::ViewHelpers
    end
  end
end

