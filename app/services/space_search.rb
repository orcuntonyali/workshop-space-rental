class SpaceSearch
    def initialize(params)
      @params = params
    end
  
    def search
      spaces = Space.all
  
      if @params[:location].present?
        spaces = spaces.where("city LIKE ? OR state LIKE ? OR country LIKE ?", "%#{@params[:location]}%", "%#{@params[:location]}%", "%#{@params[:location]}%")
      end
  
      if @params[:start_date].present? && @params[:end_date].present?
        start_date = Date.parse(@params[:start_date])
        end_date = Date.parse(@params[:end_date])
        spaces = spaces.where(created_at: start_date.beginning_of_day..end_date.end_of_day)
      end
  
      spaces
    end
  end