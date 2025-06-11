import direccion.*
import protagonista.*
object gestorDeEventos{

    method gestionarInicio(eventos){
        // Inicia todos los eventos dados, salvo que no haya ningún evento para iniciar.
        if(not eventos.isEmpty()) { eventos.forEach({e => e.iniciarEvento()}) }
    }

    // ========================================================================================================================================= \\

    method gestionarFin(eventos){
        // Finaliza todos los eventos dados, salvo que no haya ningún evento para finalizar.
        if(not eventos.isEmpty()) { eventos.forEach({e => e.finalizarEvento()}) }
    }
}

// ############################################################################################################################################# \\

object gestorDeDirecciones{
    const ejePrimero = ejeX // Representa el primer eje del tablero, en este caso es el eje X.
    const ejeSegundo = ejeY // Representa el segundo eje del tablero, en este caso es el eje Y.

    method direccionALaQueSeMovio(posicionAntigua, posicionNueva){
        // Describe la dirección a la que se movió en base a dos posiciones dadas: una antigua y otra nueva.
        return if (ejePrimero.seSumoEnEje(posicionAntigua,  posicionNueva)) { ejePrimero.primeraDir() } else
               if (ejePrimero.seRestoEnEje(posicionAntigua, posicionNueva)) { ejePrimero.segundaDir() } else
               if (ejeSegundo.seSumoEnEje(posicionAntigua,  posicionNueva)) { ejeSegundo.primeraDir() } else
                                                                            { ejeSegundo.segundaDir() }
    }
}

// ############################################################################################################################################# \\

object gestorDePosiciones{

    method lindanteConvenienteHacia(posicion, visual){
        // Describe la celda lindante que más cerca está del visual dado.
        return gestorDeColisiones.lindantesSinObstaculos(posicion, visual).min({pos => pos.distance(visual.position())})
    }

    // ========================================================================================================================================= \\

    method lindantesDe(posicion){
        // Describe todas las celdas lindantes ortogonales y diagonales de la posición dada.
        return #{posicion.up(1),   posicion.up(1).right(1),  posicion.right(1), posicion.right(1).down(1), 
                 posicion.down(1), posicion.down(1).left(1), posicion.left(1),  posicion.left(1).up(1)}
    }
}

// ############################################################################################################################################# \\

object gestorDeColisiones{

    method puedeMoverA(direccion, visual){
        // Indica si el visual dado puede moverse hacia la dirección dada.
        const posicionAMover = direccion.siguientePosicion(visual.position())
        return self.estaDentroDelTablero(posicionAMover) and not self.hayObstaculoEn(posicionAMover, visual)
    }

    // ========================================================================================================================================= \\

    method hayObstaculoEn(posicion, visual){
        // Indica si algún obstáculo en la posicion dada sin incluir al visual dado.
        return not self.objetosEnPosicion(posicion, visual).all({vis => vis.esAtravesable()})
    }

    method objetosEnPosicion(posicion, visual){
        // Describe todos los objetos en la posición dada sin el visual dado.
        return game.getObjectsIn(posicion).copyWithout(visual)
    }

    // ========================================================================================================================================= \\

    method estaDentroDelTablero(posicion){
        // Indica si la posición dada se encuentra dentro del tablero del juego.
        return self.existeX(posicion.x()) and self.existeY(posicion.y())
    }

    method existeX(x){
        // Indica si la posición x se encuentra dentro del eje X.
		return self.enLimite(x, game.width())
	} 

	method existeY(y){
        // Indica si la posición y se encuentra dentro del eje Y.
		return self.enLimite(y, game.height())
	}                                                                                              
    
    method enLimite(coord, max){
        // Indica si la coordenada dada se encuentra entre el máximo dado.
		return coord.between(0, max - 1) 
	}

    // ========================================================================================================================================= \\

    method lindantesSinObstaculos(posicion, visual){
        // Describe todas las posiciones lindantes (ortogonales y diagonales) que no tienen obstaculos sin incluir al visual dado en las mismas.
        return gestorDePosiciones.lindantesDe(posicion).filter({pos => not self.hayObstaculoEn(pos, visual)})
    }
}

// ############################################################################################################################################# \\

object gestorDeObstaculos{
    const obstaculos = []

    method agregar(elem){
        obstaculos.add(elem)
    }
    
    method limpiarObstaculos() {
        obstaculos.forEach({elem => game.removeVisual(elem)})
        obstaculos.clear()
    }
}

// ############################################################################################################################################# \\

object gestorDeVida{

    method atacadoPor(visual, enemigo){
        // Emite un mensaje cuando el enemigo es atacado por su enemigo.
        self.recibirDaño(visual, enemigo.daño())
        game.say(visual, "Mi vida es "+visual.vida()+"")
    }

    method recibirDaño(visual, dañoRecibido){
        const vidaActualizada = visual.vida() - dañoRecibido
        self.actualizarVidaYEstado(visual, vidaActualizada)
    }

    method actualizarVidaYEstado(visual, vidaActualizada){
        if(vidaActualizada <= 0){ 
            visual.actualizarAMuerto() 
        } else {
            visual.vida(vidaActualizada)
        }
    }
}

// ############################################################################################################################################# \\

object gestorDeMovimiento{
    const colisionesGestor = gestorDeColisiones

    method mover(direccion, visual){
        // Mueve al protagonista una celda hacia la dirección dada si puede mover hacia dicha dirección.
        if(colisionesGestor.puedeMoverA(direccion, visual)){
            self.moverHacia(direccion, visual)
        }
    }

    method moverHacia(direccion, visual){
        // Mueve al protagonista una celda hacia la dirección dada.
        visual.position(direccion.siguientePosicion(visual.position()))
        visual.cambiarImagen(direccion)
    }
}

// ############################################################################################################################################# \\

object gestorConversaciones{

    method configurarConversacion(esc){ 
        if(esc.hayDialogo()){
            const dialogoActual = esc.dialogo().last().copy()
            const npcEscenario =  esc.dialogo().first()

            protagonista.npcActual(npcEscenario)
            protagonista.conversacionNPC(dialogoActual)
        }
    }

    method HayDialogo(esc){
        return not esc.dialogo().isEmpty()
    }
}

// ############################################################################################################################################# \\

object gestorFondoEscenario{
    /* 
        INVARIANTE DE REPRESENTACIÓN: 
            * La imagen tiene el tamaño del tablero 1300px(ancho) x 900px(alto).
    */
    var property position = game.at(0,0)
    var property image = ""
    
    method visualizarFondo(fond){
        image = fond
        game.addVisual(self)    
    }

    method borrarFondo(){
        game.removeVisual(self)
    }

    method esAtravesable(){
        return true
    }

    method interaccion(){}
}   

// ############################################################################################################################################# \\

object gestorDeLimpiezaEscenarios{
    method limpiar(esc){
         esc.limpiarVisualesEnEscena();
         esc.dialogo([]);
         esc.eventos([]);
       }
}

// ############################################################################################################################################# \\

object gestorDeLobos{
    const obstaculos = []
    const eventosLobos = []
    
    method agregarLobos(elem,ev){
        obstaculos.add(elem);
        eventosLobos.add(ev)
    }
    
    method limpiarLobos() {
        obstaculos.forEach({elem => game.removeVisual(elem)})
        obstaculos.clear()
        eventosLobos.forEach({ev => game.removeTickEvent(ev.nombre())})
        eventosLobos.clear()
    }
}