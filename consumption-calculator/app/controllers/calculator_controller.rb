class CalculatorController < ApplicationController
	def index
	end
	
	def calculate
		begin
			@success = true
			fuel_qty_is_float = !!Float(params[:calculator][:fuel_qty]) rescue false
			distance_is_float = !!Float(params[:calculator][:distance]) rescue false
			if !fuel_qty_is_float || !distance_is_float
				@success = false
				@calc_result = "Fuel quantity must be a valid number" unless fuel_qty_is_float
				@calc_result = "#{ @calc_result.concat('; ') unless @calc_result.blank? }Distance must be a positive valid number" unless distance_is_float
			end
			if distance_is_float == 0
				@success = false
				@calc_result = "#{ @calc_result.concat('; ') unless @calc_result.blank? } Distance must be a positive valid number"
			end
			@calc_result = Calculator.calculate_to_s(params[:calculator][:fuel_qty], params[:calculator][:distance]) if @success
		rescue Exception => ex
			@success = false
			@calc_result = "Sorry, an error occurred."
		end
		render :index
	end
end
