import enemigos.*
import gestores.*
import visualesExtra.*

// ########################################################################################################################## \\

//  IMPORTANTE: Por favor no refactorizar este archivo, estoy optimizando la memoria
//  para que solo existan 6 balas y una vez disparadas el cargador de la escopeta
//  funcione como una Cola (dispara la primer bala del cargador y esta al dispararse 
//  va al final del cargador para dispararse despues) ; pero tengo que gestionar bien 
//  las consultas y el manejo de refencias.
//    
//  AVISO!!!
//  *este archivo es provisorio, quizas se mueva a estadosNPC pero se recomienda que 
//  se mantenga aqui de momento
//  * El gestorDeDirecciones tiene metodos para indicarle a la bala hacia donde disparar.
//  * La bala vive hasta que interactue con un objeto o llegue al fin del escenario(rocas).
//  * La bala tambien daña a los lobos.
//  * La baja jamas ataca al guardabosques.

// ########################################################################################################################## \\

class Ataque {
    const atacante

    method ataqueArma(){
        self.posicionesAAtacar().forEach({posicion => self.atacarEnPosicion(posicion)})
    }
  
    method atacarEnPosicion(posicion){
        self.objetosEnPosicion(posicion).forEach({objeto => objeto.atacadoPor(atacante)})
    }
 
    method objetosEnPosicion(posicion){
        return game.getObjectsIn(posicion)
    } 
    
    method posicionesAAtacar()
}

// ########################################################################################################################## \\

class AtaqueHacha inherits Ataque(){
        
    override method posicionesAAtacar() = [atacante.position().down(1),
                                           atacante.position().up(1),
                                           atacante.position().left(1),
                                           atacante.position().right(1)]
}

// ########################################################################################################################## \\

class AtaqueTridente inherits Ataque(){
    
    override method posicionesAAtacar() = [atacante.position().left(1),
                                           atacante.position().left(2),
                                           atacante.position().right(1),
                                           atacante.position().right(2)]
}

// ########################################################################################################################## \\

class AtaqueEnLugar inherits Ataque(){
    
    override method posicionesAAtacar(){
        return [atacante.position()]
    }

    override method objetosEnPosicion(posicion){
        return game.getObjectsIn(posicion).copyWithout(atacante)
    } 
}

// ########################################################################################################################## \\

class AnimacionAtaque{
    const npc  = null // el visual que ataca

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

    method atacadoPor(visual){}
 
    method esAtravesable(){
        return true
    }
}

// ################################################ ATAQUES CON ARMA DE FUEGO ############################################### \\

class Escopeta{
    const direccionesGestor = gestorDeDirecciones
    const tirador  // Quien dispara la escopeta.
    const enemigo  // Personaje al que dispara.
    const cartucho // Una instancia de Cartucho.
    const cargador = cartucho.misBalas()

    // ====================================================================================================================== \\

    method balaADisparar(){
        return cargador.first()
    }

    method posicionTirador(){
        return tirador.position()
    }

    method posicionEnemigo(){
        return enemigo.position()
    }

    method ataqueArma() {
        const miPosicion = self.posicionTirador()
        const direccionDestino = self.direccionDisparo(miPosicion)
        self.dispararEscopetaDesdeA(miPosicion, direccionDestino)
    }

    method dispararEscopetaDesdeA(posicion, direccion){
        const balaRecamara = self.balaADisparar()       
        balaRecamara.dispararse(direccion, posicion)       
        self.recargar(balaRecamara)  
    }

    method recargar(bala){
        // Encola la bala al final del cargador para reutilizar 
        cargador.remove(bala)
        cargador.add(bala)   
    }

    method direccionDisparo(posicionTirador){
        return self.direccionADisparar(self.posicionEnemigo(), posicionTirador)
    }
    
    method direccionADisparar(posicionEnemigo, posicionTirador){
        return direccionesGestor.direccionDeBala(posicionEnemigo, posicionTirador)
    }
}

// ########################################################################################################################## \\

class Bala inherits VisualAtravasable{
    var property direccion = null
    var sigoSinHerir       = false
    const colisionesGestor = gestorDeCeldasTablero
    const movimientoGestor = gestorDeMovimiento
    const trayectoriaRecursivaBala = {bala => movimientoGestor.moverHaciaSinCambiarImagen(bala.direccion(), bala);
                                              game.schedule(bala.velocidad(), {bala.gestionarTrayectoria()})}
   
    // ====================================================================================================================== \\

    override method image(){
        return "bala-"+direccion.toString()+".png"
    }

    method prepararDisparo(nuevaDireccion, posicion){
        self.direccion(nuevaDireccion)
        self.position(posicion)
    }

    method dispararse(nuevaDireccion, posicion){
        self.prepararDisparo(nuevaDireccion, posicion)
        movimientoGestor.moverHaciaSinCambiarImagen(direccion, self)
        game.addVisual(self)
        self.gestionarTrayectoria() // llamado recursivo
    }

    method gestionarTrayectoria(){
        // La bala se mueve recursivamente hasta que se den las condiciones para terminar su recorrido y morir(borrar visual).
        if(not self.puedeSeguirTrayectoria()) { self.cicloTerminado() } else 
                                              { self.aplicarTrayectoria() } // Se mueve y vuelve a llamar gestionarTrayectoria(dir).
    }

    method aplicarTrayectoria(){
        trayectoriaRecursivaBala.apply(self)
    }

    method cicloTerminado(){
        game.removeVisual(self)
    }

    override method interaccion(){
        self.hacerDaño()
        sigoSinHerir = false   
    }

    method hacerDaño(){
        self.objetosDondePenetre().forEach({objeto => objeto.atacadoPor(self)})
    } 

    method objetosDondePenetre(){
        return game.getObjectsIn(position).copyWithout(guardabosques)
    }

    // ====================================================================================================================== \\

    method daño(){
        return 10
    } 
    method velocidad(){
        return 200
    }

    method puedeSeguirTrayectoria(){       
        return sigoSinHerir or colisionesGestor.estaDentroDelTablero(self.position())
    }

    method cambiarImagen(imagen){} // Necesario solamente por polimorfismo.

    override method atacadoPor(visual){} // Necesario solamente por polimorfismo.
}