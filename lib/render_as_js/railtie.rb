require 'render_as_js/view_helpers'
module RenderAsJs
  class Railtie < Rails::Railtie
    initializer "render_as_js.view_helpers" do
      ActionView::Base.send :include, RenderAsJs::ViewHelpers
    end
  end
end

