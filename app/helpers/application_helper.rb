module ApplicationHelper

	def all_users team
		@team = team
	  @all_users ||= []
	  @all_users << @team.users
	  @all_users << @team.creator
	  @all_users.flatten
	end

	def title(page_title)
	  content_for(:title) { page_title }
	end

  def dealcolor status, archived
    return "gray" if archived === true
    if status === "Pending"
      "orange"
    elsif status === "Won"
      "green"
    else
      "red"
    end
  end
end
