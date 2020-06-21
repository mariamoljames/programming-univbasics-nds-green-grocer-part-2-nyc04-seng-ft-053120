require_relative './part_1_solution.rb'

def apply_coupons(cart, coupons)

  discount=[]
  answer=[]
  coupons.each do |coupon|
    cart.each do |car|
      if car[:item].eql?coupon[:item]
        if car[:count]>=coupon[:num]
          add_hash={
            item:car[:item]+" W/COUPON",
            price:coupon[:cost]/coupon[:num],
            clearance:car[:clearance],
            count:car[:count]-(car[:count]%coupon[:num])
          }
          discount<<add_hash
          car[:count]=car[:count]%coupon[:num]
        else
          add_hash={
            item:car[:item]+" W/COUPON",
            price:car[:price],
            clearance:car[:clearance],
            count:car[:count]
          }
          discount<<add_hash
        end
      end
    end
  end
  cart.each {|car| answer<<car}
  discount.each {|disco| answer<<disco}
  answer
end

def apply_clearance(cart)
  answer=cart
  answer.each do |ans|
    if ans[:clearance]==true
      ans[:price]*=0.8
    end
  end
  answer
end

def checkout(cart, coupons)
  answer=0.0
  consolidated=consolidate_cart(cart)
  coupon=apply_coupons(consolidated,coupons)
  clearance=apply_clearance(coupon)
  clearance.each do |x|
    coupons.each do |y|
      if x[:item].include?y[:item]x[:count]>=y[:num]
        answer+=x[:price]*x[:count]
      end
    end
  end
  answer>100.0 ? answer-=answer*0.1 : answer
  answer.round(2)
end
