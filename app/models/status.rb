class Status < ApplicationRecord
  belongs_to :lead

  def progress_level
    steps = ["Sent Invite on LinkedIn", "LinkedIn Invite Accepted", "Sent Email", "Set Meeting", "Interview Set", "Interview 2", "Interview 3", "Interview 4", "Interview 5", "Interview 6", "Interview 7", "Interview 8", "Job Offer"]
    
    steps.each_with_index do |step, index|
      if name == step
        return index 
      end
    end
  end
end
