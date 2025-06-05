import src.direccion.*
object gestorDeColisiones{
    /* 
        el gestorEntiende:

        *hayObstaculosEn(posicion,visualActual)
        *estaDentroDelTablero(posicionAMover)
        
    */
    method hayObstaculosEn(posicion, visualActual){
        return not self.objetosEnPosicion(posicion, visualActual).all({visual => visual.esAtravesable()})
    }
    
    method objetosEnPosicion(posicion, visual){
        return game.getObjectsIn(posicion).copyWithout(visual)
    }

    method estaDentroDelTablero(posicionAMover){
        return self.existeX(posicionAMover.x()) and self.existeY(posicionAMover.y())
    }

    method existeX(x){
        const anchoJuego = game.width()
		return self.enLimite(x, anchoJuego)
	} 

	method existeY(y){
        const altoJuego = game.height()
		return self.enLimite(y, altoJuego)
	}                                                                                              
    
    method enLimite(coord, max){
		return coord.between(0, max - 1) 
	}

    method puedeMoverHacia(posicionAMover, visual){
        return not self.hayObstaculosEn(posicionAMover, visual)
    }

    // #########################################################################################################################################

    method lindantesSinObstaculos(posicion, visual){
        // Agarra todas las lindantes (ortogonales y diagonales), y se queda con las que no tienen obstaculos sin incluir al visual dado en las mismas.
        return gestorDePosiciones.lindantesDe(posicion).filter({pos => not self.hayObstaculoEn(pos, visual)})
    }

    method hayObstaculoEn(posicion, visual){
        // Indica si hay obstaculos en la posicion dada sin incluir al visual dado.
        return self.posicionesConObstaculos(posicion, visual).any({pos => pos == posicion})
    }

    method posicionesConObstaculos(posicion, visual){
        // Describe los obstaculos que hay en la posición dada sin incluir al visual dado.
        return game.getObjectsIn(posicion).copyWithout(visual).map({obstaculo => obstaculo.position()})
    }
}