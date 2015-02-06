class ApplicationController < ActionController::Base
	# Prevent CSRF attacks by raising an exception.
	# For APIs, you may want to use :null_session instead.
	# protect_from_forgery with: :exception
	protect_from_forgery with: :null_session

	def sitevar(name)
	  	s = Setting.find_by_name(name)
	  	if s != nil
			if s.vartype == "string"
				return s.varval
			elsif s.vartype == "boolean"
				if s.varval == "true"
					return true
				else
					return false
				end
			elsif s.vartype == "integer"
				return s.varval.to_i
			elsif s.vartype == "float"
				return s.varval.to_f
			elsif s.vartype == "stringarray"
				return s.varval.gsub("[","").gsub("]","").gsub(", ",",").split(",")
			elsif s.vartype == "intarray"
				temp = s.varval.gsub("[","").gsub("]","").split(",")
				out = []
				temp.each do |t|
					out << temp.to_i
				end
				return out
			else
				return "ERROR - BAD VAR TYPE"
			end
		else
			return nil
		end 
	end

end
