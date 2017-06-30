require 'open-uri'
require 'json'

def isJson_hash(url)
    return JSON.parse(open(url).read)
end

def isLotto_creat
    return [*1..45].sample(6).sort
end

def isLotto_match(my_lotto, lotto_num, lotto_hash , lotto_mach_num)
    6.times do |i| 
        lotto_num.push(lotto_hash["drwtNo" + (1+i).to_s])
        
        if(my_lotto.include? lotto_num[i])
            lotto_mach_num.push(lotto_num[i])
        end
    end
end

def isLotto_show(my_lotto, lotto_num, lotto_hash , lotto_mach_num)
    puts "이번주 로또 번호는 " + lotto_num.to_s + "이고 보너스 번호는 " + lotto_hash["bnusNo"].to_s + "입니다."
    puts "추첨한 로또 번호는 " + my_lotto.to_s + "입니다"
    
    if(lotto_mach_num.size < 3)
        if(lotto_mach_num.size == 0)
            puts "겹치는 번호는 없습니다"
        else
            puts "겹치는 번호는 "+ lotto_mach_num.to_s + "입니다"
        end
        puts "결과는 꽝 입니다."
    
    elsif (lotto_mach_num.size <= 5)
        if(lotto_mach_num.size == 5 && (my_lotto.include? lotto_hash["bnusNo"]))
            lotto_mach_num.push(lotto_hash["bnusNo"])
            puts "겹치는 번호" + lotto_mach_num.to_s + "입니다"
            puts "결과는 2등 입니다."
        else
            puts "겹치는 번호" + lotto_mach_num.to_s + "입니다"
            puts "결과는 " + -(lotto_mach_num-8).to_s + "3등 입니다."
        end
    else
        puts "겹치는 번호" + lotto_mach_num.to_s + "입니다"
        puts "결과는 1등 입니다."
    end
end

my_lotto = isLotto_creat

lotto_hash = isJson_hash('http://www.nlotto.co.kr/common.do?method=getLottoNumber&drwNo=')

lotto_mach_num = Array.new

lotto_num = Array.new

isLotto_match(my_lotto, lotto_num, lotto_hash , lotto_mach_num)

isLotto_show(my_lotto, lotto_num, lotto_hash , lotto_mach_num)



