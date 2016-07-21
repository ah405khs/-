class ApplicationController < ActionController::Base

 #Prevent CSRF attacks by raising an exception.
 # For APIs, you may want to use :null_session instead.

  protect_from_forgery
  
  def rowsPerPage
  	row_size = 3
  	@rowsPerPage ||= row_size
  end


# palge list가 3 개 넘을 때 그 다음부터는 다음을 누르고 선택할수 있게끔 만들기 위해
#미구현....
  def pageListLimit
  	page_size = 3
  	@pageListLimit ||= page_size
  end
end
