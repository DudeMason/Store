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
  def takemoney(number)
    @price -= number
  end
  def list
    puts "#{@product}: $#{@price}"
  end
  def list_quantity
    puts "#{@product}: $#{@price}, Qty:#{@stock}"
  end
  def p_history
    puts "#{@product}, Qty:#{@stock} = $#{@price * @stock}"
  end
  def coupon
    @price
  end
  def add(number)
    @stock += number
  end
end

@store = []
@store << eggs = Item.new("Eggs", 3, 15)
@store << milk = Item.new("Milk", 2, 10)
@store << cereal = Item.new("Cereal", 3, 12)
@store << bread = Item.new("Bread", 4, 14)
@store << fruit = Item.new("Fruit", 1, 20)
@customer = Item.new("Customer", 200, 1)

@cart = []
@purchase_history = []

def menu
  puts "-----------------------------------"
  puts "Welcome! How can we help you today?"
  puts "1) Browse Store"
  puts "2) View Cart"
  puts "3) Checkout"
  puts "4) Purchase History"
  puts "5) Admin"
  puts "6) Exit Store"
  puts "Your Balance: $#{@customer.price.round(2)}"
  @cart_total = 0
  @cart.each {|item|
  @cart_total += item.price * item.stock}
  puts "Cart Total: $#{@cart_total.round(2)}"
  puts " "
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
    purchase_history
  when 5
    administrator
  when 6
    exit
  else
    puts "**Invalid entry, please try again!**"
    menu_get
  end
end

def browse
  puts "---------------------------"
  @store.each {|product| print product.list}
  puts "---------------------------"
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
  elsif @selection == "Back"
    menu
  elsif @selection == "1"
    menu
  elsif @selection == "Return"
    menu
  elsif @selection == "Store"
    browse
  else @selection != @store.each {|item| item.product}
    puts "------------------------------------"
    puts "**Invalid entry, please try again!**"
    puts "------------------------------------"
    browse_get
  end
end

def quantity
  puts " "
  puts "How many do you want?"
  amount = gets.strip
  @cart.each {|item|
    if @selection.product == item.product
      if @selection.stock == 0
        puts "---------------------------------------"
        puts "**Sorry, we are all out of that item!**"
        puts "---------------------------------------"
        browse_get
      elsif amount.capitalize == "None"
        puts "------------------"
        puts "**None selected!**"
        puts "------------------"
        browse_get
      elsif amount == "0"
        puts "------------------"
        puts "**None selected!**"
        puts "------------------"
        browse_get
      elsif amount.to_i == 0
        puts "------------------------------------"
        puts "**Invalid entry, please try again!**"
        puts "------------------------------------"
        quantity
      elsif amount.to_i > @selection.stock
        puts "-------------------------------"
        puts "**Our current stock is #{@selection.stock}**"
        puts "-------------------------------"
        quantity
      else item.stock += amount.to_i
        puts "------------------------------------------"
        puts "#{@selection.product} has been added to cart!"
        puts "------------------------------------------"
        browse_get
      end
    end}
  if @selection.stock == 0
    puts "---------------------------------------"
    puts "**Sorry, we are all out of that item!**"
    puts "---------------------------------------"
    browse_get
  elsif amount.capitalize == "None"
    puts "------------------"
    puts "**None selected!**"
    puts "------------------"
    browse_get
  elsif amount == "0"
    puts "------------------"
    puts "**None selected!**"
    puts "------------------"
    browse_get
  elsif amount.to_i == 0
    puts "------------------------------------"
    puts "**Invalid entry, please try again!**"
    puts "------------------------------------"
    quantity
  elsif amount.to_i > @selection.stock
    puts "-------------------------------"
    puts "**Our current stock is #{@selection.stock}**"
    puts "-------------------------------"
    quantity
  elsif amount.to_i < @selection.stock
    @selection.takestock(amount.to_i)
    @cart << Item.new(@selection.product, @selection.price, amount.to_i)
    puts "------------------------------------------"
    puts "#{@selection.product} has been added to cart!"
    puts "------------------------------------------"
    browse_get
  elsif amount.to_i == @selection.stock
    @selection.takestock(amount.to_i)
    @cart << Item.new(@selection.product, @selection.price, amount.to_i)
    puts "------------------------------------------"
    puts "#{@selection.product} has been added to cart!"
    puts "------------------------------------------"
    browse_get
  else
    puts "--------------------------------"
    puts "**Sorry, something went wrong!**"
    puts "--------------------------------"
    browse
  end
end

def view_cart
  puts "---------------------"
  puts "--This is your cart--"
  puts "---------------------"
  @cart.each {|item| print item.list_quantity}
  puts "---------------------"
  view_cart_gets
end

def view_cart_gets
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
    @cart.each {|item|
    if @choice == item
      item.takestock(amount)
    end}
    @store.each {|item|
    if @choice.product == item.product
      item.stock += amount
    end}
    puts "----------"
    puts "*Success!*"
    view_cart
  elsif
    @choice.stock == amount
    @cart.delete(@choice)
    @store.each {|item|
    if @choice.product == item.product
      item.stock += amount
    end}
  end
end

def checkout
  @cart_total = @cart_total + (@cart_total * 0.06)
  puts "----------------------------------------"
  puts "Your total is $#{@cart_total.round(2)} after tax!"
  puts "----------------------------------------"
  puts "1) Pay"
  puts "2) Apply Coupon"
  puts "3) View Cart"
  puts "4) Back to Menu"
  puts "5) Exit Store"
checkout_gets
end

def checkout_gets
  input = gets.strip.to_i
  case input
  when 1
    make_history
  when 2
    coupon #pay
  when 3
    view_cart
  when 4
    menu
  when 5
    exit
  else
    puts "------------------------------------"
    puts "**Invalid entry, please try again!**"
    puts "------------------------------------"
    checkout_gets
  end
end

def coupon
  puts "Enter your coupon code:"
  puts "(15% off for you, you handsome devil) ->56982<- "
  code = gets.strip.to_i
  if code == 56982
    @new_cart_total = @cart_total - (@cart_total * 0.15)
    puts "--------------------"
    puts "**Coupon applied!!**"
    new_checkout
  else
    puts "----------------------------"
    puts "**Sorry, that didn't work!**"
    puts "----------------------------"
    checkout
  end
end

def make_history
  if @cart_total.round(2) > @customer.price
    puts "----------------------------------"
    puts "***You don't have enough money!***"
    checkout
  else
    @customer.takemoney(@cart_total.round(2))
    puts "---------------------------------"
    puts "--Thank you for your purchase!!--"
    @cart.each {|item|
    @purchase_history << item}
    @cart.clear
    menu
  end
end

def purchase_history
  if @purchase_history == nil
    puts "----------------------------------"
    puts "**You have no purchase history!!**"
    puts "----------------------------------"
    menu
  else
    puts "-----------------------------"
    puts "This is your purchase history"
    puts "-----------------------------"
    @purchase_history.each {|item| print item.p_history}
    history_total = 0
    @purchase_history.each {|item|
    history_total += item.price * item.stock}
    history_total = history_total + (history_total * 0.06)
    puts "Purchase Total after tax = $#{history_total.round(2)}"
    menu
  end
end

def new_checkout
  puts "----------------------------------------"
  puts "Your new total is $#{@new_cart_total.round(2)}!"
  puts "----------------------------------------"
  puts "1) Pay"
  puts "2) View Cart"
  puts "3) Back to Menu"
  puts "4) Exit Store"
new_checkout_gets
end

def new_checkout_gets
  input = gets.strip.to_i
  case input
  when 1
    new_make_history #pay
  when 2
    view_cart
  when 3
    menu
  when 4
    exit
  else
    puts "------------------------------------"
    puts "**Invalid entry, please try again!**"
    puts "------------------------------------"
    new_checkout_gets
  end
end

def new_make_history
  if @new_cart_total.round(2) > @customer.price
    puts "----------------------------------"
    puts "***You don't have enough money!***"
    new_checkout
  else
    @customer.takemoney(@new_cart_total.round(2))
    puts "---------------------------------"
    puts "-----You saved $#{(@cart_total * 0.15).round(2)}!-----"
    puts "--Thank you for your purchase!!--"
    @cart.each {|item|
      item.price = item.price - (item.price * 0.15)}
    @cart.each {|item|
      @purchase_history << item}
    @cart.clear
    menu
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

def exit
  puts "----------------"
  puts "--- GOODBYE! ---"
  puts "--COME AGAIN!---"
  puts "----------------"
end

menu
