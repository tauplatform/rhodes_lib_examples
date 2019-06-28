# The model has already been created by the framework, and extends Rhom::RhomObject
# You can add more methods here
class Model1
  include Rhom::PropertyBag

  # Uncomment the following line to enable sync with Model1.
  # enable :sync

  #add model specific code here


  def self.getAllItems
      puts "$$$ Model1.getAllItems START"
      items = Model1.find(:all)
      puts "$$$ Model1.getAllItems FINISH"
      items
  end

  def self.getAllItemsAsHashes
      puts "$$$ Model1.getAllItemsAsHashes START"
      items = Model1.find(:all)
      ar = []
      items.each do |model1|
          h = {}
          h["attr1"] = model1.attr1
          h["attr2"] = model1.attr2
          h["attr3"] = model1.attr3
          ar << h
      end
      puts "$$$ Model1.getAllItemsAsHashes FINISH"
      ar
  end


  def self.fillModelByPredefinedSet
      puts "$$$ Model1.fillModelByPredefinedSet START"
      item = Model1.new({'attr1' => 'ZORRRRO', 'attr2' => 'XORRRO', 'attr3' => 'CORRRRO'})
      item.save
      item = Model1.new({'attr1' => '111', 'attr2' => '222', 'attr3' => '333'})
      item.save
      puts "$$$ Model1.fillModelByPredefinedSet FINISH"
  end

  def self.callRubyNativeCallback
      puts "$$$ Model1.callNativeCallback START"
      Rho::Ruby.callNativeCallback("mySuperMegaRubyNativeCallbackID", "test string param ZZZ");
      puts "$$$ Model1.callNativeCallback FINISH"
  end

  def self.getArrayWithAllValuesOfParamAllItemsByParamName(param_name)
      puts "$$$ Model1.getArrayWithAllValuesOfParamAllItemsByParamName START param_name = "+param_name
      items = Model1.find(:all)
      ar = []
      items.each do |model1|
          ar << model1.attr1 if param_name == "attr1"
          ar << model1.attr2 if param_name == "attr2"
          ar << model1.attr3 if param_name == "attr3"
      end
      puts "$$$ Model1.getArrayWithAllValuesOfParamAllItemsByParamName FINISH"
      ar
  end

  def self.receiveAllItemAsArrayOfHashesWithParams(param1, param2)
      puts "$$$ Model1.receiveAllItemAsHashWithParams START"
      puts "$$$ input param1 = "+param1.to_s
      puts "$$$ input param2 = "+param2.to_s
      puts "$$$ input params example parse - param1['key1_array'][1] = "+param1['key1_array'][1].to_s
      puts "$$$ input params example parse - param1['key3_bool'] = "+param1['key3_bool'].to_s
      puts "$$$ Model1.receiveAllItemAsHashWithParams FINISH"
      return getAllItemsAsHashes
  end




end
