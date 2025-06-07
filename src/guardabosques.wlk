import visualesExtra.*
import protagonista.*
import direccion.*
import estadosNPC.*
import gestores.*

object guardabosques inherits Visual{

    const enemigo = protagonista
    var property image = "guardabosques-cabaña.png"

    var property position = game.at(5,5)

    var property vida = 20

    const presa = protagonista

    //const colisionesGestor  = gestorDeColisiones
    const direccionesGestor = gestorDeDirecciones
    const posicionesGestor  = gestorDePosiciones

    
    var dioleña=false
    var estado = armadoGuardabosques

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


    /*
        LOS SIGUIENTES 3 METODOS SON SIMILARES A LOS DEL LOBO PERO CON IMPLEMENTACION DISTINTA
    */
   
    method perseguirAPresa() {
        if (self.estaCercaProtagonista() ) { 
            estado.ataque() } 
        else { self.avanzarHaciaLaPresa() }
    }

    method avanzarHaciaLaPresa() {
        const positionAntigua = position
        position = self.siguientePosicion()
        self.cambiarImagen(direccionesGestor.direccionALaQueSeMovio(positionAntigua, position))
    }

    method siguientePosicion() = posicionesGestor.lindanteConvenienteHacia(position, presa)
    /*
    method siguientePosicion() {
        return if (colisionesGestor.hayLindantesSinObstaculosSin(position, presa)) { 
                   posicionesGestor.lindanteConvenienteHacia(position, presa) 
               }
    }
*/
    method estaVivo() = self.vida() > 0

    override method atacado(){
        game.say(self,"Me esta atacando el protagonista")
    }

    method estaCercaProtagonista(){ return
        estado.posicionesParaCalcularAtaque().contains(presa.position())
    }

    method estaSobreProtagonista() = self.position() == presa.position()



     method cambiarImagen(direccion){ self.image(estado.actual()+direccion.toString()+".png") } 

    // ##########################################

    method miCeldaArriba() = arriba.siguientePosicion(position)
    method miCeldaAbajo() = abajo.siguientePosicion(position)
    method miCeldaIzquierda()= izquierda.siguientePosicion(position)
    method miCeldaDerecha()= derecha.siguientePosicion(position)
}