class Admin::Product < ApplicationRecord
  include PgSearch::Model
  has_one_attached :image
  belongs_to :brand, class_name: 'Admin::Brand'
  belongs_to :category, class_name: 'Admin::Category'

  scope :search, ->(query) { where("name ILIKE ?", "%#{query}%") if query.present? }

  def to_combobox_display
    name
  end

  pg_search_scope :search_by_name,
                  against: :name,
                  using: {
                    dmetaphone: {},
                    trigram: {},
                    tsearch: { prefix: true, any_word: true }
                  }
end
