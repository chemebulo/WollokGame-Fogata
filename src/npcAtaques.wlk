import enemigos.*
import gestores.*
import visualesExtra.*

// ########################################################################################################################## \\

class Ataque {
    const atacante // Representa al atacante que realiza el ataque.

    method ataqueArma(){
        // En todas la posiciones a atacar, se realiza el ataque con su respectivo daño hacia todos los visual que alcance.
        self.posicionesAAtacar().forEach({posicion => self.atacarEnPosicion(posicion)})
    }
  
    method atacarEnPosicion(posicion){
        // El atacante cargado realiza el ataque en la posición dada.
        self.objetosEnPosicion(posicion).forEach({objeto => objeto.atacadoPor(atacante)})
    }
 
    method objetosEnPosicion(posicion){
        // Describe todos los objetos que hay en la posición dada.
        return game.getObjectsIn(posicion)
    } 
    
    method posicionesAAtacar() // Describe todas las posiciones a atacar.

    method daño() // Describe el daño que realiza el ataque.
}

// ########################################################################################################################## \\

class AtaqueTridente inherits Ataque(){
    
    override method posicionesAAtacar(){
        // Describe todas las posiciones a atacar.
        return [atacante.position().left(1),
                atacante.position().left(2),
                atacante.position().right(1),
                atacante.position().right(2)]
    }

    override method daño(){
        // Describe el daño que realiza el ataque.
        return 3
    }
}

// ########################################################################################################################## \\

class AtaqueHacha inherits Ataque(){
        
    override method posicionesAAtacar(){
        // Describe todas las posiciones a atacar.
        return [atacante.position().down(1),
                atacante.position().up(1),
                atacante.position().left(1),
                atacante.position().right(1)]
    }

    override method daño(){
        // Describe el daño que realiza el ataque.
        return 5
    }
}

// ########################################################################################################################## \\

class AtaqueEnLugar inherits Ataque(){
    
    override method posicionesAAtacar(){
        // Describe todas las posiciones a atacar.
        return [atacante.position()]
    }

    override method objetosEnPosicion(posicion){
        // Describe todos los objetos que hay en la posición dada sin incluir al visual dado.
        return game.getObjectsIn(posicion).copyWithout(atacante)
    }

    override method daño(){
        // Describe el daño que realiza el ataque.
        return 7
    }
}

// ########################################################################################################################## \\

class AnimacionAtaque{
    const npc  = null // Representa el NPC que realiza el ataque.

    method animarAtaque(){
        // Realiza una secuencia de instrucciones que consisten en remover/agregar la imagen de un visual para dar sensación de animación.
        const imagenActual = npc.image()
        game.removeVisual(npc) 
        npc.image(npc.imagenTemporal())
        game.addVisual(npc)
        game.schedule(200, {game.removeVisual(npc); 
                            npc.image(imagenActual); 
                            game.addVisual(npc)})
    }

    method atacadoPor(visual){} // Método conservado únicamente por polimorfismo.
 
    method esAtravesable(){
        // Describe que la animación es atravesable, aunque en realidad es conservado únicamente por polimorfismo.
        return true
    }
}

// ################################################ ATAQUES CON ARMA DE FUEGO ############################################### \\

class Escopeta{
    const direccionesGestor = gestorDeDirecciones // Representa el gestor de direcciones que utiliza la escopeta, el cual indica a la bala hacia donde ir.
    const tirador                                 // Representa el visual que es el tirador de la escopeta.
    const enemigo                                 // Representa el enemigo al cual se dispara la escopeta.
    const cartucho                                // Representa el cartucho que tiene la escopeta.
    const cargador = cartucho.misBalas()          // Representa el cargador que tiene la escopeta.

    // ====================================================================================================================== \\

    method ataqueArma(){
        // Realiza el ataque de la escopeta desde la posición actual del tirador hacia la dirección hacia donde mire el mismo.
        const posicionTirador = self.posicionTirador()
        const direccionDestino = self.direccionDisparo(posicionTirador)
        self.dispararEscopetaDesdeA(posicionTirador, direccionDestino)
    }

    method dispararEscopetaDesdeA(posicion, direccion){
        // Dispara la escopeta desde la posición dada hacia la dirección dada.
        const balaRecamara = self.balaADisparar()       
        balaRecamara.dispararse(direccion, posicion)       
        self.recargar(balaRecamara)  
    }

    method recargar(bala){
        // Recarga el cargador con la bala dada.
        cargador.remove(bala)
        cargador.add(bala)   
    }

    method direccionDisparo(posicionTirador){
        // Describe la dirección de disparo mediante la posición del tirador.
        return self.direccionADisparar(self.posicionEnemigo(), posicionTirador)
    }
    
    method direccionADisparar(posicionEnemigo, posicionTirador){
        // Describe la dirección a disparar mediante la posicion del enemigo y del tirador.
        return direccionesGestor.direccionDeBala(posicionEnemigo, posicionTirador)
    }

    // ====================================================================================================================== \\

    method balaADisparar(){
        // Describe la primera bala en el cargador de la escopeta.
        return cargador.first()
    }

    method posicionTirador(){
        // Describe la posición del tirador de la escopeta.
        return tirador.position()
    }

    method posicionEnemigo(){
        // Describe la posición del enemigo de la escopeta.
        return enemigo.position()
    }
}

// ########################################################################################################################## \\

class Bala inherits VisualAtravesable{
    var property direccion = null                  // Representa la dirección hacia la cual va la bala.
    var sigoSinHerir       = false                 // Representa 
    const colisionesGestor = gestorDeCeldasTablero // Representa el gestor de colisiones que utiliza la bala.
    const movimientoGestor = gestorDeMovimiento    // Representa el gestor de movimiento que utiliza la bala.
    const trayectoriaBala  = {bala => movimientoGestor.moverHaciaSinCambiarImagen(bala.direccion(), bala); // Representa la trayectoria de la bala.
                                      game.schedule(bala.velocidad(), {bala.gestionarTrayectoria()})} 
   
    // ====================================================================================================================== \\

    method dispararse(nuevaDireccion, posicion){
        // Se dispara la bala desde la posición dada hacia la dirección dada. 
        self.prepararDisparo(nuevaDireccion, posicion)
        movimientoGestor.moverHaciaSinCambiarImagen(direccion, self)
        game.addVisual(self)
        self.gestionarTrayectoria()
    }

    method prepararDisparo(nuevaDireccion, posicion){
        // Prepara el disparo de la bala, modificando su dirección y su posición por la dadas por parámetro.
        self.direccion(nuevaDireccion)
        self.position(posicion)
    }

    method gestionarTrayectoria(){
        // Gestiona la trayectoria de la bala, la cual se mueve recursivamente hasta que se den las condiciones para terminar.
        if(not self.puedeSeguirTrayectoria()) { self.cicloTerminado() } else 
                                              { self.aplicarTrayectoria() }
    }

    method puedeSeguirTrayectoria(){
        // Indica si la bala puede seguir su trayecto. 
        return sigoSinHerir or colisionesGestor.estaDentroDelTablero(self.position())
    }

    method cicloTerminado(){
        // Al haber terimnado el ciclo, se remueve la bala del juego.
        game.removeVisual(self)
    }

    method aplicarTrayectoria(){
        // Aplica la trayectoria de la bala cargada en la misma.
        trayectoriaBala.apply(self)
    }

    override method interaccion(){
        // Representa la interacción de la bala al chocar con un visual.
        self.hacerDaño()
        sigoSinHerir = false   
    }

    method hacerDaño(){
        // La bala realiza daño a cada visual que haya alcanzado.
        self.visualAlcanzados().forEach({visual => visual.atacadoPor(self)})
    } 

    method visualAlcanzados(){
        // Describe todos los visuales que fueron alcanzados por la bala.
        return game.getObjectsIn(position).copyWithout(guardabosques)
    }

    // ====================================================================================================================== \\

    override method image(){
        // Describe la imagen actual de la bala.
        return "bala-"+direccion.toString()+".png"
    }

    method daño(){
        // Describe el daño de la bala.
        return 10
    } 

    method velocidad(){
        // Describe la velocidad de la bala.
        return 200
    }

    override method atacadoPor(visual){} // Necesario únicamente por polimorfismo.

    method cambiarImagen(imagen){} // Necesario únicamente por polimorfismo.
}