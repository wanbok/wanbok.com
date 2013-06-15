class Survey < ActiveRecord::Base
	ATTRS = [:age, :sex, :title, :user]
	(1..15).each do |q|
		ATTRS.push("q#{q}".to_sym)
	end
  attr_accessible *ATTRS

  validates *ATTRS, presence: true
end
