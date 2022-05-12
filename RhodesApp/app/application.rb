require 'rho/rhoapplication'

class AppApplication < Rho::RhoApplication
  def initialize
    # Tab items are loaded left->right, @tabs[0] is leftmost tab in the tab-bar
    # Super must be called *after* settings @tabs!
    @tabs = nil
    #To remove default toolbar uncomment next line:
    #@@toolbar = nil
    super

    puts "$$$ ~~before sleep 10"
    #sleep(10)
    puts "$$$ ~~after sleep 10"

    Rho::Ruby.callNativeCallback("myCallbackForFinishRubyInitialization", nil)

    puts "$$$ native callback was called"


  end
end
