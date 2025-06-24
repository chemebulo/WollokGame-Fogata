import protagonista.*
import enemigos.*
import npcMovimiento.*
import gestores.*
import direccion.*
import visualesExtra.*
import npcEstados.*

/*
        IMPORTANTE: Por favor no refactorizar este archivo, estoy optimizando la memoria
        para que solo existan 6 balas y una vez disparadas el cargador de la escopeta
        funcione como una Cola (dispara la primer bala del cargador y esta al dispararse 
        va al final del cargador para dispararse despues) ; pero tengo que gestionar bien 
        las consultas y el manejo de refencias.
    

        AVISO!!!
            *este archivo es provisorio, quizas se mueva a estadosNPC pero se recomienda que 
             se mantenga aqui de momento
            * El gestorDeDirecciones tiene metodos para indicarle a la bala hacia donde disparar.
            *La bala vive hasta que interactue con un objeto o llegue al fin del escenario(rocas)
            *La bala tambien daña a los lobos
            *La baja jamas ataca al guardabosques


*/


// ########################################################################################################################## \\
//                                                   ATAQUES CUERPO A CUERPO
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

class AtaqueHacha inherits Ataque{
        
    override method posicionesAAtacar() = [atacante.position().down(1),
                                           atacante.position().up(1),
                                           atacante.position().left(1),
                                           atacante.position().right(1)]
}

class AtaqueTridente inherits Ataque{
    
    override method posicionesAAtacar() = [atacante.position().left(1),
                                           atacante.position().left(2),
                                           atacante.position().right(1),
                                           atacante.position().right(2)]
}
class AtaqueManopla inherits Ataque{
    
    override method posicionesAAtacar(){
        return [atacante.position()]
    }

    override method objetosEnPosicion(posicion){
        return game.getObjectsIn(posicion).copyWithout(atacante)
    } 
}
class AnimacionAtaque{
    /*
        animarAtaque() : realiza una secuencia de de instrucciones que consisten en remover/agregar y settear la imagen de un visual
                         para dar sensacion de animacion
    */
    const imagenTemp = ""   // la imagen que se muestra cuando se ataca
    const pjAnimado  = null // el visual que ataca

    method animarAtaque(){
        const imagenActual = pjAnimado.image()

        game.removeVisual(pjAnimado) 
        pjAnimado.image(imagenTemp)
        game.addVisual(pjAnimado)
        game.schedule(200,{game.removeVisual(pjAnimado); 
                           pjAnimado.image(imagenActual); 
                           game.addVisual(pjAnimado)})
    }
    method atacadoPor(visual){}
 
    method esAtravesable() = true
}


// ########################################################################################################################## \\
//                                                   ATAQUES CON ARMA DE FUEGO
// ########################################################################################################################## \\
class Escopeta{


    const gestorDireccionBala = gestorDeDirecciones
    const tirador // quien dispara la escopeta
    const enemigo //personaje al que dispara
    
   const cartucho // una instancia de Cartucho
   const cargador = cartucho.misBalas()
   
   method balaADisparar() = cargador.first()
  
    
    method posTirador() = tirador.position()

    method posEnemigo() = enemigo.position()

    method ataqueArma() {
        const miPosicion = self.posTirador()
        const direccion = self.direccionDisparo(miPosicion)
        self.dispararEscopeta(miPosicion,direccion)
    }

    method dispararEscopeta(pos,direccion){
        const balaRecamara = self.balaADisparar()       
        balaRecamara.dispararse(direccion, pos)       
        self.recargar(balaRecamara)  
    
    }

    method recargar(bala){
        // Proposito: encola la bala al final del cargador para reutilizar 
        cargador.remove(bala)
        cargador.add(bala)   
    }


    method direccionDisparo(posTirador)= self.direccionADisparar(self.posEnemigo(),posTirador)
    
    method direccionADisparar(posEnemigo,posTirador){
            return gestorDireccionBala.direccionDeBala(posEnemigo,posTirador)
        }
            
}

class Bala inherits VisualAtravasable{

    var  property dir = null
    const gestorColision = gestorDeColisiones
    const gestorMov = gestorDeMovimiento
    var sigoSinHerir = false

    const trayectoriaRecursivaBala = {bala=> gestorMov.moverHaciaSinCambiarImagen(bala.dir(), bala) ;
                                                 game.schedule(bala.velocidad(), {bala.gestionarTrayectoria()})}
   
    override method image() = "bala-"+ dir.toString()+".png"

    method prepararDisparo(direccion,posicion){
         self.dir(direccion)
        self.position(posicion)
    }

    method dispararse(direccion,posicion){
        self.prepararDisparo(direccion, posicion)
        
        gestorMov.moverHaciaSinCambiarImagen(dir, self)
        game.addVisual(self)
       // miArma.recargar(self)
        self.gestionarTrayectoria() // llamado recursivo

    }
        
    method gestionarTrayectoria(){
    /*
        Proposito: la bala se mueve recursivamente hasta que se den las condiciones
        para terminar su recorrido y morir(borrar visual)
    */
         
         if(not self.puedeSeguirTrayectoria() ) {              
            self.cicloTerminado()
            }
          else { 
              trayectoriaRecursivaBala.apply(self) // se mueve y vuelve a llamar gestionarTrayectoria(dir)
            }
    }
   method cicloTerminado(){game.removeVisual(self)}

   
    

    override method interaccion(){
        self.hacerDaño()
        sigoSinHerir = false   
    }

    method hacerDaño(){self.objetosDondePenetre().forEach({o => o.atacadoPor(self)})} 

    method objetosDondePenetre() = game.getObjectsIn(self.position()).copyWithout(guardabosques)

    // #########################################################
    // #########################################################

    method daño() = 10 
    method velocidad() = 200 // mls

    method puedeSeguirTrayectoria(){       
       return  sigoSinHerir || gestorColision.estaDentroDelTablero(self.position())
    }

    method cambiarImagen(imagen){
        // la bala nunca cambia su imagen pero es necesario este metodo por polimorfismo
    }

    override   method atacadoPor(visual){}
    //necesario por polimorfismo porque podria 
}

   
    
