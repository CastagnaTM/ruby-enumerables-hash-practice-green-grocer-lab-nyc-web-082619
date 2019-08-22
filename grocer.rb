def consolidate_cart(cart)
  new_cart = {}
  cart.each do |n|
	if new_cart[n.keys[0]]
		new_cart[n.keys[0]][:count] += 1
	else
	new_cart[n.keys[0]] = {
		count: 1,
		price: n.values[0][:price],
		clearance: n.values[0][:clearance]
	}
	end
end
new_cart
end

def apply_coupons(cart, coupons)
  coupons.each do |n|
		if cart.include?(n[:item]) && cart[n[:item]][:count] >= n[:num]
      if cart["#{n[:item]} W/COUPON"]
				cart["#{n[:item]} W/COUPON"][:count] += n[:num]
			else
   		 cart["#{n[:item]} W/COUPON"] = {
				 :price => (n[:cost]/n[:num]),
				 :clearance => cart[n[:item]][:clearance],
				 :count => n[:num]
			 }
			end
		cart[n[:item]][:count] -= n[:num]
	end
end
cart
end

def apply_clearance(cart)
  cart.each do |n|
    if n[1][:clearance] == true
      n[1][:price] = (n[1][:price] * 0.80).round(2)
    end
    cart
  end
end

def checkout(cart, coupons)
  cart = consolidate_cart(cart)
  cart = apply_coupons(cart, coupons)
  cart = apply_clearance(cart)
  total = 0
  cart.each do |n|
    total += n[1][:price]
  end
  total

end
