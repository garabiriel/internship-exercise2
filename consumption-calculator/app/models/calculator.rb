class Calculator

	def self.calculate(qty, distance)
		qty*100/distance
	end
	
	def self.calculate_to_s(qty, distance)
		"Fuel consumption for #{qty} liters and #{distance} kilometers: #{ '%.2f' % self.calculate(qty.to_f, distance.to_f)} l/ 100 kilometers"
	end
end
