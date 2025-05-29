object gestorDeColisiones{
    /* 
        el gestorEntiende:

        *hayObstaculosEn(posicion,visualActual)
        *estaDentroDelTablero(posicionAMover)
        
    */
    method hayObstaculosEn(posicion,visualActual){

    return not self.objetosEnPosicion(posicion,visualActual).all({visual => visual.esAtravesable()})
    }
    method objetosEnPosicion(posicion,visual){
        return game.getObjectsIn(posicion).copyWithout(visual)
    }

    method estaDentroDelTablero(posicionAMover){
        return  self.existeX(posicionAMover.x()) and self.existeY(posicionAMover.y())
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
}