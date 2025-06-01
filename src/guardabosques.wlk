import visualesExtra.*
import videojuego.*
import protagonista.*

object guardabosques inherits Visual{

    const enemigo = protagonista
    var property image = "guardabosques-cabaña.png"

    var property position = game.at(5,5)

    
    var dioleña=false

    override method esAtravesable() = false

     method interaccion(){}

     method xPos() = self.position().x() // para conversar con npc

     

    /* method terminoDialogo(){
        //return videojuego.escenario().dialogo().head().isEmpty()
        return videojuego.escenario().dialogo().last().last().isEmpty()
     }
     */
    method comprobarDialogo(){

            if(self.terminoDialogo() and (not dioleña)){
                self.darLeña()
                dioleña=true
            }
    }

    method terminoDialogo() = enemigo.conversacionNPC().isEmpty()        
        

    method darLeña() {game.addVisual(leña) }
}

object pasivo{
    method dar(){
        game.addVisual(leña)
    }
}
object traidor{}

