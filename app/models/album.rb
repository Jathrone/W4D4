class Album < ApplicationRecord
    validates :title, :band_id, :year, presence: true #presence check on boolean values fails at 'false'
    validates :is_studio, inclusion: {in: [true, false]}

    belongs_to :band,
        primary_key: :id,
        foreign_key: :band_id,
        class_name: :Band

    has_many :tracks,
        primary_key: :id,
        foreign_key: :album_id, 
        class_name: :Track,
        dependent: :destroy
end
