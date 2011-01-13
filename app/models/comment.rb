class Comment < ActiveRecord::Base

	belongs_to :image
	belongs_to :user
  has_many :report, :dependent => :destroy

  attr_accessible :user_id, :image_id, :body

  validates :user_id, :presence => true
  validates :image_id, :presence => true
  validates :body, :presence => true

  def self.set_report_count(comment)
    for report in Report.where(:comment_id => comment.id)
      report.destroy
    end
  end
end
