class Category < ActiveRecord::Base
	has_many :article_categories
	has_many :articles , through: :article_categories
	validates_presence_of :name
end
