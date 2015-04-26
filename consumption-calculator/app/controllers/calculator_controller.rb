class CalculatorController < ApplicationController
	def index
	end
	
	def calculate
		begin
			@success = true
			@fuel_qty = params[:calculator][:fuel_qty]
			@distance = params[:calculator][:distance]
			error_messages = Array.new
			if !is_a_valid_term?(@fuel_qty)
				@success = false
				error_messages << invalid_term_message("Fuel quantity")
			end
			if !is_a_valid_term?(@distance)
				@success = false
				error_messages << invalid_term_message("Distance")
			end
			if @success
				@calc_result = Calculator.calculate_to_s(@fuel_qty, @distance)
				@fuel_qty = nil
				@distance = nil
			else
				@error_msg = format_error_messages(error_messages)
			end
		rescue Exception => ex
			@success = false
			@error_msg = "Sorry, an error occurred: #{ ex.message }"
		end
		render :index
	end
	
	private
	
	def is_float_parsable?(var)
		!!Float(var) rescue false
	end
	
	def is_a_valid_term?(term)
		is_float_parsable?(term) && Float(term) > 0
	end
	
	def invalid_term_message(term_name)
		"#{term_name} must be a valid positive number"
	end
	
	def format_error_messages(error_messages)
		final_message = ''
		error_messages.each do |msg|
			final_message << ' ;' if final_message.length > 0
			final_message << msg
		end
		final_message
	end
end
