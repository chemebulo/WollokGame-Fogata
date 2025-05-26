class Diapositiva{
    var property position = game.at(0,0)
    var property image 
    
   method esAtravesable() = true 

   method interaccion() = game.removeVisual(self)
}