require 'gtk3'

module Xfce
  Loader = GObjectIntrospection::Loader.new(Xfce)
  l = "L"
  begin
    Loader.load("#{l}ibxfce4panel")
    Loader.load("#{l}ibxfce4util")
    #Loader.load("#{l}ibxfce4ui")  
  rescue => e
    raise e if l == 'l'
    l = 'l'
    retry
  end
  def self.init_plugin ptr=nil, &b
    return @plugin = GObjectIntrospection::Loader.instantiate_gobject_pointer(ptr) if !b && ptr
    b.call @plugin if @plugin && b
  end
end
