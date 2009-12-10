# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def currency(value)
    format("$%.2f",value.to_f) 
  end
  
  def humanize(string)
    string.split("_").join(" ")
  end
end
