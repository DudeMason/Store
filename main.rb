require 'pry'

class Item
  attr_accessor :product, :price, :stock

  def initialize(product, price, stock)
    @product = product
    @price = price
    @stock = stock
  end
  def takestock(number)
    @stock -= number
  end
  def list
    puts "#{@product}: $#{@price}"
  end
  def list_quantity
    puts "#{@product}: $#{@price}, Qty:#{@stock}"
  end
  def coupon
    @price
  end
end

@store = []
@store << eggs = Item.new("Eggs", 3, 15)
@store << milk = Item.new("Milk", 2, 10)
@store << cereal = Item.new("Cereal", 3, 12)
@store << bread = Item.new("Bread", 4, 14)
@store << fruit = Item.new("Fruit", 1, 20)

@cart = []

def menu
  puts "-----------------------------------"
  puts "Welcome! How can we help you today?"
  puts "1) Browse Store"
  puts "2) View Cart" #put remove item option and option to checkout
  puts "3) Checkout" #apply taxes and put a coupon option
  puts "4) Admin"
  puts "5) Exit"
  menu_get
end

def menu_get
  userselect = gets.strip.to_i
  case userselect
  when 1
    browse
  when 2
    view_cart
  when 3
    checkout
  when 4
    administrator
  when 5
    exit
  else
    puts "**Invalid entry, please try again!**"
    menu_get
  end
end

def administrator
  puts "PASSWORD:"
  password = gets.strip
  if password == "Admin"
    admin
  else
    puts "-------------------"
    puts "***Invalid entry***"
    puts "-------------------"
    menu
  end
end

def admin
  puts "What would you like to do?"
  puts "1) Add store product"
  puts "2) Remove store product"
  puts "3) Fire Marc"
  puts "4) Return to Menu"
  admin_gets
end

def browse
  puts "----------------------------"
  @store.each {|product| print product.list}
  puts "----------------------------"
  browse_get
end

def browse_get
  puts "Type the product you wish to select"
  puts "Or type 'Menu' to return to menu"
  @selection = gets.strip.capitalize
  @store.each {|item|
    if @selection == item.product
        @selection = item
        quantity
    end}
  if @selection == "Menu"
    menu
  else @selection != @store.each {|item| item.product}
    puts "------------------------------------"
    puts "**Invalid entry, please try again!**"
    puts "------------------------------------"
    browse_get
  end
end

def quantity
  puts "How many do you want?"
  amount = gets.strip.to_i
  if @selection.stock == 0
    puts "---------------------------------------"
    puts "**Sorry, we are all out of that item!**"
    puts "---------------------------------------"
    browse_get
  elsif amount == 0
    puts "------------------------------------"
    puts "**Invalid entry, please try again!**"
    puts "------------------------------------"
    quantity
  elsif amount > @selection.stock
    puts "*Our current stock is #{@selection.stock}*"
    quantity
  else
    @selection.takestock(amount)
    @cart << Item.new(@selection.product, @selection.price, amount)
    puts "------------------------------------------"
    puts "#{@selection.product} has been added to cart!"
    puts "------------------------------------------"
    browse_get
  end
end

def admin_gets
  answer = gets.strip.to_i
  case answer
  when 1
    add_store_product
  when 2
    remove_store_product
  when 3
    puts "-----------------------------------------"
    puts "That is completely and utterly IMPOSSIBLE"
    puts "You are crazy"
    puts "-----------------------------------------"
    admin
  when 4
    menu
  end
end

def view_cart
  @cart.each {|item| print item.list_quantity}
  view_cart_gets
end

def view_cart_gets
  puts "------------------------"
  puts "1) Remove Item"
  puts "2) Checkout"
  puts "3) Back to Menu"
  input = gets.strip.to_i
  case input
  when 1
    remove_item
  when 2
    checkout
  when 3
    menu
  else
    puts "------------------------------------"
    puts "**Invalid entry, please try again!**"
    puts "------------------------------------"
    view_cart_gets
  end
end

def remove_item
  puts "Which item would you like to remove?"
  puts "Or type 'Cart' to return to cart."
  @choice = gets.strip.capitalize
  @cart.each {|item|
    if @choice == item.product
      @choice = item
      quantity_remove
    end}
  if @choice == "Cart"
    view_cart
  else
    puts "------------------------------------"
    puts "**Invalid entry, please try again!**"
    puts "------------------------------------"
    remove_item
  end
end

def quantity_remove
  puts "How many would you like to remove?"
  amount = gets.strip.to_i
  if
    @choice.stock == 0
    puts "------------------------------------------"
    puts "**Weird... you don't have any more left!**"
    puts "------------------------------------------"
    view_cart
  elsif
    amount == 0
    puts "------------------------------------"
    puts "**Invalid entry, please try again!**"
    puts "------------------------------------"
    quantity_remove
  elsif
    amount > @choice.stock
    puts "----------------------------"
    puts "*That's more than you have!*"
    puts "----------------------------"
    quantity_remove
  elsif
    amount < @choice.stock
    @choice.takestock(amount)
    puts "----------"
    puts "*Success!*"
    puts "----------"
    view_cart
  elsif
    @choice.stock == amount
    @cart.delete(@choice)
    view_cart
  end
end

def add_store_product
  puts "----------------------------"
  @store.each {|product| print product.list_quantity}
  puts "----------------------------"
  add_store_product_gets
end
def add_store_product_gets
  puts "What item would you like to add?"
  product = gets.strip.to_s.capitalize
  puts "How much will it cost?"
  price = gets.strip.to_i
  puts "How many in stock?"
  stock = gets.strip.to_i
  @store << product = Item.new(product, price, stock)
  puts "---------------"
  puts "**Item Added!**"
  puts "---------------"
  admin
end

def remove_store_product
  puts "----------------------------"
  @store.each {|product| print product.list_quantity}
  puts "----------------------------"
  remove_store_product_gets
end
def remove_store_product_gets
  puts "What would you like to remove?"
  toberemoved = gets.strip.capitalize
  @store.each {|product|
  if toberemoved == product.product
    toberemoved = product
    @store.delete(toberemoved)
    puts "--------------------------------------------"
    puts "**#{product.product} successfully removed!**"
    puts "--------------------------------------------"
    admin
  end}
  @store.each {|product|
  if toberemoved != product.product
    puts "---------------------------"
    puts "That is not a store product"
    puts "---------------------------"
    remove_store_product_gets
  end}
end

def checkout
  @cart_total = 0
	@cart.each { |product|
		@cart_total += product.price * product.stock
    @cart_total = @cart_total - (@cart_total * 0.06)
	}
  total
end

def total
  puts "----------------------------------------"
  puts "Your total is $#{@cart_total.round(2)} after tax!"
  puts "----------------------------------------"
  puts "1) Apply Coupon?"
  puts "2) Pay and Exit"
  puts "3) Back to Menu"
checkout_gets
end

def checkout_gets
  input = gets.strip.to_i
  case input
  when 1
    puts "Enter your coupon code:"
    puts "(15% off for you, you handsome devil) ->56982<- "
    code = gets.strip.to_i
    if code == 56982
      @cart_total = @cart_total - (@cart_total * 0.15)
      puts "--------------------"
      puts "**Coupon applied!!**"
      puts "--------------------"
      total
    else
      puts "----------------------------"
      puts "**Sorry, that didn't work!**"
      puts "----------------------------"
      checkout
    end
  when 2
    exit
  when 3
    menu
  else
    puts "------------------------------------"
    puts "**Invalid entry, please try again!**"
    puts "------------------------------------"
    checkout_gets
end

def exit
  puts "--- GOODBYE! ---"
end
end



menu
