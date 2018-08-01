module VeterinariesHelper
	def setup_veterinary(veterinary)
    veterinary.user ||= User.new
    veterinary
  end
end
