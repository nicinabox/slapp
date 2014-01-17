module Helpers
  def convert_to_bytes(string)
    units = {
      :'K' => 1024,
      :'MB' => 1024 * 1024
    }

    formula = units.map {|u| u.last if string.include? u.first.to_s }.compact
    string.to_i * formula.first
  end
end
