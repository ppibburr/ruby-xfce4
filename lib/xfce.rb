require 'gtk3'

module Xfce
  Loader = GObjectIntrospection::Loader.new(Xfce)
  l      = "L"
  
  begin
    Loader.load("#{l}ibxfce4panel")
    
    begin
      ## These are
      ## not required
      Loader.load("#{l}ibxfce4util")
      #Loader.load("#{l}ibxfce4ui")  
    rescue => e
    end
  rescue => e
    raise e if l == 'l'
    l = 'l'
    retry
  end
  def self.init_plugin ptr=nil, &b
    if !b && ptr
      @plugin = GObjectIntrospection::Loader.instantiate_gobject_pointer(ptr) 
      return @plugin
    end
    @plugin.children[0].destroy
    b.call @plugin if @plugin && b
  end
end
