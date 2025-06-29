import direccion.*
import protagonista.*
import enemigos.*
import puertas.*


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
  
    method direccionDeBala(posEnemigo, posTirador){
        // Evalua la posicion entre el protagonista y el tirador y retorna la direccion de disparo.
        const xEnemigo = self.xPos(posEnemigo)
        const xTirador = self.xPos(posTirador)
        const yEnemigo = self.yPos(posEnemigo)
        const yTirador = self.yPos(posTirador)

        return self.direccionDeDisparoEvaluada(xEnemigo, yEnemigo, xTirador, yTirador)
    }

    method direccionDeDisparoEvaluada(xE, yE, xP, yP){
        // Dados unos pares de valores x,y evalua hacia donde disparar
        return if (self.estaAMiIzquierda(xE, xP)) { izquierda } else 
               if (self.estaAMiDerecha(xE,xP))    { derecha   } else 
               if (self.estaArriba(yE, yP))       { arriba    } else 
                                                  { abajo     }
    }

    method estaAMiIzquierda(posEnemigoX, posPropioX){
        return posEnemigoX < posPropioX
    }

    method estaAMiDerecha(posEnemigoX, posPropioX){
        return posEnemigoX > posPropioX
    }

    method estaArriba(posEnemigoY, posPropioY){
        return posEnemigoY > posPropioY
    }

    method xPos(pos){
        return pos.x()
    }

    method yPos(pos){
        return pos.y()
    }
}

// ############################################################################################################################################# \\

object gestorDeCeldasTablero{

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
        return self.lindantesDe(posicion).filter({pos => not self.hayObstaculoEn(pos, visual)})
    }

    // ========================================================================================================================================= \\

    method hayLindanteSinObstaculo(posicion, visual){
        return not self.lindantesSinObstaculos(posicion, visual).isEmpty()
    }

    method lindanteConvenienteHacia(posicion, visual){
        // Describe la celda lindante que más cerca está del visual dado.
        const lindantesSinObstaculo = self.lindantesSinObstaculos(posicion, visual)
        /*
            Me quedo como cosa dejar ese if, propongo esta solucion, se puede volver a la anterior si se desea.
            El if se pregunta si la coleccion de lindantes esta vacia y luego le pedia el minimo a lindanteSinObstaculos,
             con el minIfEmpty hace internamente lo que hace el if,si hay posiciones, devuelve la minima
            y si esta vacio (basicamente lo que comprueba el if) devuelve la posicion. el metodo hayLindanteSinObstaculo
            podria usarse para una validacion o podria eliminarse.
            El lindanteSiHay es para lejibilidad
        */

      //  if(self.hayLindanteSinObstaculo(posicion, visual)){
          //  return lindantesSinObstaculo.min({pos => pos.distance(visual.position())})
        //} else {
        //    return posicion

        //}
          
          return  self.lindanteSiHay(lindantesSinObstaculo,posicion,visual)
    }
    
    method lindanteSiHay(lindantes,posicion,visual){
             return lindantes.minIfEmpty({pos => pos.distance(visual.position())},{posicion})
     }

    

    // ========================================================================================================================================= \\

    method lindantesDe(posicion){
        // Describe todas las celdas lindantes ortogonales y diagonales de la posición dada.
        return #{posicion.up(1),   posicion.up(1).right(1),  posicion.right(1), posicion.right(1).down(1), 
                 posicion.down(1), posicion.down(1).left(1), posicion.left(1),  posicion.left(1).up(1)}
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
        game.say(visual, "Vida: "+visual.vida()+"")
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
    const colisionesGestor = gestorDeCeldasTablero // Representa al gestor de colisiones que se va a tomar de referencia.

    method mover(direccion, visual){
        // Mueve al protagonista una celda hacia la dirección dada si puede mover hacia dicha dirección.
        self.validarSiPuedeMover(direccion, visual)
        self.moverHacia(direccion, visual)
    }

    method moverHacia(direccion, visual){
        // Mueve al protagonista una celda hacia la dirección dada.
        visual.position(direccion.siguientePosicion(visual.position()))
        visual.cambiarImagen(direccion)
    }

    method validarSiPuedeMover(direccion, visual){
        if(not colisionesGestor.puedeMoverA(direccion, visual)){
            self.error("No me puedo mover en esa dirección")
        }
    }

    method moverHaciaSinCambiarImagen(direccion,visual){
        // Mueve al visual sin modificar su imagen
        visual.position(direccion.siguientePosicion(visual.position()))
    }
}

// ############################################################################################################################################# \\

object gestorFondoEscenario{
    var property position = game.at(0,0)
    var property image = "" // La imagen tiene que ser de tamaño 1300px(ancho) x 900px(alto).
    
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



object gestorDeLobos{
    const lobosEscenario = []
    const  eventosLobos  = []
    
    method agregarLobos(lobo){
        self.crearLoboGestionable(lobo)
        self.iniciarCicloAtaque(lobo)
    }

    method iniciarCicloAtaque(lobo){
        lobo.eventoPersecucion().iniciarEvento()
        lobo.eventoAtaque().iniciarEvento()
    }
    

    method crearLoboGestionable(lobo){
          lobosEscenario.add(lobo);
          eventosLobos.add(lobo.eventoPersecucion())
          eventosLobos.add(lobo.eventoAtaque())
    }
    
    method limpiarLobos(){
        lobosEscenario.forEach({lobo => self.resetearLobo(lobo)})
        eventosLobos.forEach({ev => self.resetearEventoLobo(ev)})
    }

    method resetearLobo(lobo){
        game.removeVisual(lobo)
        lobosEscenario.remove(lobo)
    }

    method resetearEventoLobo(ev){
        game.removeTickEvent(ev.nombreEvento())
        eventosLobos.remove(ev)
    }
}

// ############################################################################################################################################# \\