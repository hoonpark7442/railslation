require "rouge/plugins/redcarpet"

module Redcarpet
  module Render
    class HTMLRouge < HTML
      include Rouge::Plugins::Redcarpet

    end
  end
end
