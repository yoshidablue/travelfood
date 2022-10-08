class Post < ApplicationRecord

  has_many :favorites,     dependent: :destroy
  has_many :food_comments, dependent: :destroy

  has_one_attached :image

  belongs_to :customer
  belongs_to :prefecture

  validates :image,         presence: true
  validates :prefecture_id, presence: true
  validates :food_name,     presence: true
  validates :introduction,  presence: true, length:{maximum: 50}

  def favorited_by?(customer)
    favorites.exists?(customer_id: customer.id)
  end

end