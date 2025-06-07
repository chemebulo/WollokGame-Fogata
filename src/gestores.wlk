import direccion.*

object gestorDeEventos {

    // INTERFAZ:
    //  * gestionarInicio(eventos)
    //  * gestionarFin(eventos)

    method gestionarInicio(eventos){
        if(not eventos.isEmpty()) { eventos.forEach({e => e.iniciarEvento()}) }
    }

    // ========================================================================================================================================= \\

    method gestionarFin(eventos){
        if(not eventos.isEmpty()) { eventos.forEach({e => e.finalizarEvento()}) }
    }
}

// ############################################################################################################################################# \\

object gestorDeDirecciones {

    // INTERFAZ:
    //  * direccionALaQueSeMovio(posicionAntigua, posicionNueva)

    const ejePrimero = ejeX
    const ejeSegundo = ejeY

    method direccionALaQueSeMovio(posicionAntigua, posicionNueva){
        return if (ejePrimero.seSumoEnEje(posicionAntigua,  posicionNueva)) { ejePrimero.primeraDir() } else
               if (ejePrimero.seRestoEnEje(posicionAntigua, posicionNueva)) { ejePrimero.segundaDir() } else
               if (ejeSegundo.seSumoEnEje(posicionAntigua,  posicionNueva)) { ejeSegundo.primeraDir() } else
                                                                            { ejeSegundo.segundaDir() }
    }
}

// ############################################################################################################################################# \\

object gestorDePosiciones {

    // INTERFAZ:
    //  * lindanteConvenienteHacia(posicion, visual)
    //  * lindantesDe(posicion)

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

    // INTERFAZ:
    //  * hayObstaculoEn(posicion, visual)  
    //  * estaDentroDelTablero(posicion)
    //  * lindantesSinObstaculos(posicion, visual) 
    //  * hayLindantesSinObstaculosSin(posicion, visual)

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

    method hayLindantesSinObstaculosSin(posicion, visual){
        // Indica si hay celdas lindantes sin obstaculos en desde la posición dada, sin incluir al visual dado en las mismas.
        return not self.lindantesSinObstaculos(posicion, visual).isEmpty()
    }
}