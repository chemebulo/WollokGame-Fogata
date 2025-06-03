import visualesExtra.*
import videojuego.*
import protagonista.*
import direccion.*
import estadosNPC.*

object guardabosques inherits Visual{

    const enemigo = protagonista
    var property image = "guardabosques-cabaña.png"

    var property position = game.at(5,5)

    
    var dioleña=false
    var estado = desarmadoGuardabosques

    method estado(_estado){estado=_estado}

    override method esAtravesable() = false

     method interaccion(){}

     method xPos() = self.position().x() // para conversar con npc

     

   // Metodos usados para dar la leña al principio
    method comprobarDialogo(){

            if(self.terminoDialogo() and (not dioleña)){ // como comprobarDialogo() es llamado por un evento en eventos.wlk 
                                                          //se necesitan bolleanos para que solo se ejecute una vez
                self.darLeña()
                dioleña=true
            }
    }

    method terminoDialogo() = enemigo.conversacionNPC().isEmpty()        
        
    method darLeña() {game.addVisual(leña) }


    //ATAQUE AL PROTAGONISTA 
    method atacar(){
        estado.ataque()
    }

    method miCeldaArriba() = arriba.siguientePosicion(position)
    method miCeldaAbajo() = abajo.siguientePosicion(position)
    method miCeldaIzquierda()= izquierda.siguientePosicion(position)
    method miCeldaDerecha()= derecha.siguientePosicion(position)

}
