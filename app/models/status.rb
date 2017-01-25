class Status < ApplicationRecord
  belongs_to :lead

  def progress_level
    if name == "Sent Invite on LinkedIn"
      return 0
    elsif name == "LinkedIn Invite Accepted"
      return 1        
    elsif name == "Sent Email"
      return 2
    elsif name == "Set Meeting"
      return 3
    elsif name == "Interview Set"
      return 4
    elsif name == "Job Offer"
      return 5        
    end
  end
end
