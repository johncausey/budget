module ApplicationHelper

  def this_month
    Time.zone.now.strftime("%B")
  end

end
