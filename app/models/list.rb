class List < ApplicationRecord
  has_many :bookmarks
  has_many :movies, through: :bookmarks
  # validates_uniqueness_of :name
  validates :name, presence: true, uniqueness: true

  before_destroy :destroy_child_movies

  private

  def destroy_child_movies
    self.movies.destroy_all
  end
end
