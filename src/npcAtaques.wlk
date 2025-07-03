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
        self.posicionesAAtacar().forEach({pos => self.atacarEnPosicion(pos)})
    }
  
    method atacarEnPosicion(pos){
        self.objetosEnPosicion(pos).forEach({obj => obj.atacadoPor(atacante)})
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
    const gestorDireccionBala = gestorDeDirecciones
    const tirador  // Quien dispara la escopeta.
    const enemigo  // Personaje al que dispara.
    const cartucho // Una instancia de Cartucho.
    const cargador = cartucho.misBalas()

    // ====================================================================================================================== \\

    method balaADisparar(){
        return cargador.first()
    }

    method posTirador(){
        return tirador.position()
    }

    method posEnemigo(){
        return enemigo.position()
    }

    method ataqueArma() {
        const miPosicion = self.posTirador()
        const direccion = self.direccionDisparo(miPosicion)
        self.dispararEscopeta(miPosicion, direccion)
    }

    method dispararEscopeta(pos,direccion){
        const balaRecamara = self.balaADisparar()       
        balaRecamara.dispararse(direccion, pos)       
        self.recargar(balaRecamara)  
    }

    method recargar(bala){
        // Encola la bala al final del cargador para reutilizar 
        cargador.remove(bala)
        cargador.add(bala)   
    }

    method direccionDisparo(posTirador){
        return self.direccionADisparar(self.posEnemigo(), posTirador)
    }
    
    method direccionADisparar(posEnemigo, posTirador){
        return gestorDireccionBala.direccionDeBala(posEnemigo, posTirador)
    }
}

// ########################################################################################################################## \\

class Bala inherits VisualAtravasable{
    var property dir = null
    var sigoSinHerir = false
    const gestorColision = gestorDeCeldasTablero
    const gestorMov      = gestorDeMovimiento
    const trayectoriaRecursivaBala = {bala => gestorMov.moverHaciaSinCambiarImagen(bala.dir(), bala);
                                              game.schedule(bala.velocidad(), {bala.gestionarTrayectoria()})}
   
    // ====================================================================================================================== \\

    override method image(){
        return "bala-"+ dir.toString()+".png"
    }

    method prepararDisparo(direccion,posicion){
        self.dir(direccion)
        self.position(posicion)
    }

    method dispararse(direccion,posicion){
        self.prepararDisparo(direccion, posicion)
        gestorMov.moverHaciaSinCambiarImagen(dir, self)
        game.addVisual(self)
        self.gestionarTrayectoria() // llamado recursivo
    }
        
    method gestionarTrayectoria(){
        // La bala se mueve recursivamente hasta que se den las condiciones para terminar su recorrido y morir(borrar visual).
        if(not self.puedeSeguirTrayectoria()){              
            self.cicloTerminado()
        } else { 
            trayectoriaRecursivaBala.apply(self) // Se mueve y vuelve a llamar gestionarTrayectoria(dir).
        }
    }

    method cicloTerminado(){
        game.removeVisual(self)
    }

    override method interaccion(){
        self.hacerDaño()
        sigoSinHerir = false   
    }

    method hacerDaño(){
        self.objetosDondePenetre().forEach({o => o.atacadoPor(self)})
    } 

    method objetosDondePenetre(){
        return game.getObjectsIn(self.position()).copyWithout(guardabosques)
    }

    // ====================================================================================================================== \\

    method daño(){
        return 10
    } 
    method velocidad(){
        return 200
    }

    method puedeSeguirTrayectoria(){       
        return sigoSinHerir or gestorColision.estaDentroDelTablero(self.position())
    }

    method cambiarImagen(imagen){
        // Necesario solamente por polimorfismo.
    }

    override method atacadoPor(visual){} // Necesario solamente por polimorfismo.
}