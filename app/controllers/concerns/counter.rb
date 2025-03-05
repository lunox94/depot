module Counter
  private

    def increment_counter
      @counter = session[:counter] = session.fetch(:counter, 0) + 1
    end

    def reset_counter
      @counter = session[:counter] = 0
    end
end
