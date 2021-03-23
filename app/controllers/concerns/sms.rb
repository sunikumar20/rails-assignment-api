module Sms
	extend ActiveSupport::Concern
	included do
		attr_accessor :text
		validates_length_of :text, minimum: 1, maximum: 120, message: 'min length 1 max length 120', allow_blank: true
	end
end