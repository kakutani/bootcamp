# frozen_string_literal: true

class Question < ApplicationRecord
  include Searchable
  include Reactionable
  include Watchable
  include WithAvatar
  include Taggable

  belongs_to :practice, optional: true
  belongs_to :user, touch: true
  has_one :correct_answer, dependent: :destroy
  has_many :answers, dependent: :destroy
  alias sender user

  after_create QuestionCallbacks.new
  after_destroy QuestionCallbacks.new

  validates :title, presence: true, length: { maximum: 256 }
  validates :description, presence: true
  validates :user, presence: true

  scope :solved, -> { joins(:correct_answer) }
  scope :not_solved, -> { where.not(id: CorrectAnswer.pluck(:question_id)) }

  columns_for_keyword_search :title, :description
end
