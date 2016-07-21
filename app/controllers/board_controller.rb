class BoardController < ApplicationController
include ApplicationHelper

  def index
  #	@boardList = MyRailsBoardRow.all.order("created_at desc").limit(rowsPerPage) 
  #	@totalCnt = MyRailsBoardRow.all.count
  #	@current_page = 1
  #	@totalPageList = getTotalPageList(@totalCnt, rowsPerPage)
  	url = "/listSpecificPageWork?current_page=1"
  	redirect_to url
  end

  def show_write_form
  end

  def DoWriteBoard
  	@rowData = MyRailsBoardRow.new( name: params[:name], mail: params[:mail],
            subject: params[:subject], memo: params[:memo], hits:0)

    @rowData.save

    redirect_to '/'
  end

  def listSpecificPageWork
  	@totalCnt = MyRailsBoardRow.all.count
  	@current_page = params[:current_page]
  	@totalPageList = getTotalPageList(@totalCnt, rowsPerPage)
  	@boardList = MyRailsBoardRow.find_by_sql [
  		"select * from MY_RAILS_BOARD_ROWS 
  		ORDER BY id desc 
  		limit %s offset %s", 
  		rowsPerPage, @current_page.to_i ==1 ? 0 : rowsPerPage*(@current_page.to_i-1) ]

  end

  def viewWork
  	@id = params[:id]
    @current_page = params[:current_page]
    @searchStr= params[:searchStr]
        MyRailsBoardRow.increment_counter(:hits, @id ) # hits increase
    @rowData = MyRailsBoardRow.find(params[:id])
  end


  def listSearchedSpecificPageWork
    @searchStr = params[:searchStr]
    @pageForView = params[:pageForView]

                
    @totalCnt = MyRailsBoardRow.where("subject LIKE ?","%#{@searchStr}%").count()
                       
    @totalPageList = getTotalPageList( @totalCnt, rowsPerPage)        
      
      #where name, mail, memo like%%s%% 하면 다른놈으로도 검색가능  
    @boardList = MyRailsBoardRow.find_by_sql [
        "select * from MY_RAILS_BOARD_ROWS 
        where subject like '%%%s%%' 
        ORDER BY id desc
        limit %s offset %s",
        @searchStr,rowsPerPage, @pageForView.to_i ==1 ? 0 : rowsPerPage*(@pageForView.to_i-1) ] 
                
        
   end

   def searchWithSubject
    @searchStr = params[:searchStr]
        
    url = '/listSearchedSpecificPageWork?searchStr=' + @searchStr +'&pageForView=1'
    redirect_to url
   end


end
