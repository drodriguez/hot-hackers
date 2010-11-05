module HackersHelper
  def class_for_hacker_row(position)
    case position
    when 1 then "first"
    when 2 then "second"
    when 3 then "third"
    else        ""
    end
  end
end
