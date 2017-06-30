class LottoController < ApplicationController
  def shownum
    require 'open-uri'
    require 'json'
    
    @my_lotto = [*1..45].sample(6).sort
    
    @lotto_open = open 'http://www.nlotto.co.kr/common.do?method=getLottoNumber&drwNo=' 
    
    @lotto_read = @lotto_open.read
    
    @lotto_hash = JSON.parse @lotto_read
    
    @lotto_bonus = @lotto_hash["bnusNo"]
    
    @lotto_num = []
    
    @lotto_hash.each do |key, value|
        @lotto_num << value if key.include? 'drwtNo'
    end
    
    @lotto_num = @lotto_num.sort
    
    @match_number = @lotto_num & @my_lotto
    
    @count = @match_number.count
    
    @result = ""
    
    case @count
    when 0, 1, 2
     @result = "꽝"
    when 3
      @result = "5등"
    when 4
      @result = "너 4등"
    when 5
        if(@my_lotto.include? @lotto_bonus ) 
            @result = "너 2등"
        else
            @result = "너 3등"
        end
    else
      @result = "너 1등"
    end
  end
  
  def clikview
    
  end
end
