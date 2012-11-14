class ApplicationController < ActionController::Base
  before_filter :redirect_to_canonical_host

  protect_from_forgery
  include SessionsHelper

  def redirect_to_canonical_host
    canonical_host = APP_CONFIG['canonical_host']
    if canonical_host && request.host != canonical_host
      redirect_to "#{request.protocol}#{canonical_host}:#{request.port}#{request.fullpath}"
    end
  end
end
