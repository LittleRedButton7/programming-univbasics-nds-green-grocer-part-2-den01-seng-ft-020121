require_relative './part_1_solution.rb'

def apply_coupons(cart, coupons)
 count = 0 
 while count < coupons.length 
  cart_item = find_item_by_name_in_collection(coupons[count][:item], cart)
  couponed_item_name = "#{coupons[count][:item]} W/COUPON"
  cart_item_with_coupon = find_item_by_name_in_collection(couponed_item_name, cart)
  if cart_item && cart_item[:count] >= coupons[count][:num]
    if cart_item_with_coupon
      cart_item_with_coupon[:count] += coupons[count][:num]
      cart_item[:count] -= coupons[count][:num]
    else cart_item_with_coupon = {
      :item => couponed_item_name,
      :price => coupons[count][:cost] / coupons[count][:num],
      :count => coupons[count][:num],
      :clearance => cart_item[:clearance]
    }
    cart << cart_item_with_coupon
    cart_item[:count] -= coupons[count][:num]
    end
  end
  count += 1
 end
 cart
end

def apply_clearance(cart)
  count = 0 
  while count < cart.length 
    if cart[count][:clearance] == true
      cart[count][:price] = (cart[count][:price] - (cart[count][:price] * 0.20)).round(2)
    end  
  count += 1
  end
  cart
end

def checkout(cart, coupons)
  consolidated_cart = consolidate_cart(cart)
  couponed_cart = apply_coupons(consolidated_cart, coupons)
  final_cart = apply_clearance(couponed_cart)
  
  total = 0 
  count = 0 
  while count < final_cart.length 
    total += final_cart[count][:price] * final_cart[count][:count]
    count += 1
  end
  if total > 100
    total -= (total * 0.10)
  end  
  total
end
