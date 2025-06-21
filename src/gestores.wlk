import direccion.*
import protagonista.*
import enemigos.*
import puertas.*


object gestorDeEventos{

    method gestionarInicio(eventos){
        // Inicia todos los eventos dados, salvo que no haya ningún evento para iniciar.
        if(not eventos.isEmpty()){
            eventos.forEach({e => e.iniciarEvento()})
        }
    }

    // ========================================================================================================================================= \\

    method gestionarFin(eventos){
        // Finaliza todos los eventos dados, salvo que no haya ningún evento para finalizar.
        if(not eventos.isEmpty()){ 
            eventos.forEach({e => e.finalizarEvento()})
        }
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

  //Codigo para la bala, solo la bala deberia llamarlo
  // se recomienda no factorizar porque esta masomenos optimizado

    method direccionDeBala(posEnemigo,posPropia){
            const xE = self.xPos(posEnemigo)
            const xP = self.xPos(posPropia)
           const yE = self.yPos(posEnemigo)
            const yP = self.yPos(posPropia)


     return  if (self.estaAMiIzquierda(xE, xP)){izquierda} 
             else if (self.estaAMiDerecha(xE,xP) ) {derecha}
             else if (self.estaArriba(yE, yP)) {arriba}
             else {abajo}
           

    }
    method estaAMiIzquierda(posEnemigoX, posPropioX) = posEnemigoX < posPropioX

    method estaAMiDerecha(posEnemigoX, posPropioX) = posEnemigoX > posPropioX

    method estaArriba(posEnemigoY,posPropioY) = posEnemigoY > posPropioY

    method xPos(pos) = pos.x()

    method yPos(pos) = pos.y()
}

// ############################################################################################################################################# \\

object gestorDePosiciones{
    const colisionesGestor  = gestorDeColisiones  // Representa el gestor de colisiones.

    method lindanteConvenienteHacia(posicion, visual){
        // Describe la celda lindante que más cerca está del visual dado.
        const lindantesSinObstaculo = colisionesGestor.lindantesSinObstaculos(posicion, visual)

        if(colisionesGestor.hayLindanteSinObstaculo(posicion, visual)){
            return lindantesSinObstaculo.min({pos => pos.distance(visual.position())})
        } else {
            return posicion
        }
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

    // ========================================================================================================================================= \\

    method hayLindanteSinObstaculo(posicion, visual){
        return not self.lindantesSinObstaculos(posicion, visual).isEmpty()
    }
}

// ############################################################################################################################################# \\

object gestorDeObstaculos{
    const obstaculos = [] // Describe una colección con los obstaculos que existen en el escenario actual.

    method agregar(elemento){
        // Agrega un elemento a la lista de obstaculos.
        obstaculos.add(elemento)
    }
    
    method limpiarObstaculos(){
        // Limpia todos los obstaculos que se encuentren en la lista de obstaculos.
        obstaculos.forEach({elemento => game.removeVisual(elemento)})
        obstaculos.clear()
    }
}

// ############################################################################################################################################# \\

object gestorDeVida{

    method atacadoPor(visual, enemigo){
        // Actualiza la vida del visual dado con el daño del enemigo dado, y además el visual emite un mensaje describiendo su vida actual.
        self.recibirDaño(visual, enemigo.daño())
        game.say(visual, "Mi vida es "+visual.vida()+"")
    }

    method recibirDaño(visual, dañoRecibido){
        // Actualiza la vida y el estado del visual dado con el daño del enemigo dado.
        const vidaActualizada = visual.vida() - dañoRecibido
        self.actualizarVidaYEstado(visual, vidaActualizada)
    }

    method actualizarVidaYEstado(visual, vidaActualizada){
        // Actualiza la vida y el estado del visual dado. Si la vida actualizada es menor o igual a cero, el visual muere.
        if(vidaActualizada <= 0){ 
            visual.actualizarAMuerto() 
        } else {
            visual.vida(vidaActualizada)
        }
    }
}

// ############################################################################################################################################# \\

object gestorDeMovimiento{
    const colisionesGestor = gestorDeColisiones // Representa al gestor de colisiones que se va a tomar de referencia.

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

object gestorFondoEscenario{
    /* 
        INVARIANTE DE REPRESENTACIÓN: 
            * La imagen tiene el tamaño del tablero 1300px(ancho) x 900px(alto).
    */
    var property position = game.at(0,0)
    var property image = ""
    
    method visualizarFondo(nuevoFondo){
        image = nuevoFondo
        game.addVisual(self)    
    }

    method borrarFondo(){
        game.removeVisual(self)
    }

    method esAtravesable(){
        return true
    }

    method interaccion(){}

    method atacadoPor(visual){}

 
}   

// ############################################################################################################################################# \\

object gestorDeListasEscenario{
    
    method limpiarListas(esc){
        self.limpiarListaVisuales(esc)
        esc.eventos([])
    }

    method limpiarListaVisuales(esc){
        self.limpiezaDeVisuales(esc.visualesEnEscena())
    }

    method limpiezaDeVisuales(visuales){
        visuales.forEach({visual => game.removeVisual(visual)})
    }

    method agregarVisualesEscena(esc){
        self.agregarVisuales(esc.visualesEnEscena())
    }

    method agregarVisuales(visuales){
        visuales.forEach({v => game.addVisual(v)})
    } 
}

// ############################################################################################################################################# \\

object gestorDeLobos{
    const lobosEscenario = []
    const eventosLobos   = []
    
    method agregarLobos(lobo){
        lobosEscenario.add(lobo);
        eventosLobos.add(lobo.eventoPersecucion())
        eventosLobos.add(lobo.eventoAtaque())
        lobo.eventoPersecucion().iniciarEvento()
        lobo.eventoAtaque().iniciarEvento()
    }
    
    method limpiarLobos(){
        lobosEscenario.forEach({lobo => game.removeVisual(lobo)})
        lobosEscenario.clear()
        eventosLobos.forEach({ev => game.removeTickEvent(ev.nombreEvento())})
        eventosLobos.clear()
    }
}

// ############################################################################################################################################# \\