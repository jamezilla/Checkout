class Category < ActiveRecord::Base

  ## Macros ##

  include Autocomplete
  resourcify

  ## Associations ##

  has_and_belongs_to_many :models


  ## Validations ##

  validates :name, :presence => true
  validates :name, :uniqueness => true


  ## Mass-assignable Attributes ##

  attr_accessible :name, :description

  ## Class methods ##

  def self.suggest(category_ids)
    raise "catgory_ids must be an Array" unless category_ids.is_a? Array
    suggestions = []
    current_categories = Category.includes(:models).joins(:models).find(category_ids)

    current_categories.each do |c|
      c.models.each { |m| suggestions << m.categories }
    end

    suggestions.flatten.uniq.sort - current_categories
  end

  ## Instance methods ##

  # TODO: move this to a select2 specific decorator method
  def as_json(options = {})
    {
      id: id,
      name: name
    }
  end

  def to_s
    name
  end

end
