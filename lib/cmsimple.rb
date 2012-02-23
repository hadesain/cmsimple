require "cmsimple/version"
require 'rails'
require 'haml-rails'
require 'formtastic'
require 'mercury-rails'
require 'spine-rails'
require 'cells'
require 'haml_coffee_assets'

module Cmsimple
  class Configuration
    def initialize
      self.parent_controller = 'ApplicationController'
      self.template_path = 'cmsimple/templates'
      self.template_strategy = :basic
    end

    attr_accessor :parent_controller, :template_path
    attr_writer :template_strategy

    def template_strategy
      case @template_strategy
      when :basic
        Cmsimple::TemplateResponder
      else
        @template_strategy.constantize
      end
    end
  end

  class << self
    attr_accessor :configuration

    # Configure CMSimple
    #
    def configure
      self.configuration ||= Configuration.new
      yield self.configuration
    end
  end
end

require 'cmsimple/rails'
require 'cmsimple/template_resolver'
require 'cmsimple/template_responder'
require 'cmsimple/regions_proxy'

