class Admin::Product < ApplicationRecord
  include PgSearch::Model
  has_one_attached :image
  belongs_to :brand, class_name: 'Admin::Brand'
  belongs_to :category, class_name: 'Admin::Category'

  pg_search_scope :search_by_name,
                  against: :name,
                  using: {
                    dmetaphone: {},
                    trigram: {},
                    tsearch: { prefix: true, any_word: true }
                  }
end
