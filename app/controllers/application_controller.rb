class ApplicationController < ActionController::API

  def money(cents)
    '%.2f' % (cents.to_f / 100)
  end

end
