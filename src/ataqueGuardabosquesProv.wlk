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
class ArmadoEscopeta inherits Armado(pj=guardabosques,
                                     modoAtaque= escopetaGuardabosques,
                                     imagenTemporal="guardabosques-dispara.png"){

    // va a disparar en todo momento, no me importa donde este el prota
    override method puedeAtacarAlEnemigo() = true 
}

object escopetaGuardabosques{
   
    const gestorDireccionBala = gestorDeDirecciones
    const tirador =guardabosques
    const enemigo = protagonista
    
   const misBalas = [bala1,bala2,bala3,bala4,bala5,bala6]
   
   method balaADisparar() = misBalas.first()
  
    
    method posTirador() = tirador.position()

    method posEnemigo() = enemigo.position()

    method ataqueArma() {
        const miPosicion = self.posTirador()
        const direccion = self.direccionDisparo(miPosicion)
        self.dispararEscopeta(miPosicion,direccion)
    }

    method dispararEscopeta(pos,direccion){
     
        self.prepararBala(pos,direccion)
        self.balaADisparar().disparar()
        game.addVisual(self.balaADisparar())
        misBalas.remove(self.balaADisparar())    
    
    }

    method prepararBala(posicion,direccion){
        self.balaADisparar().dir(direccion)
        self.balaADisparar().position(posicion)
    }

    method recargar(bala){
        misBalas.add(bala) //encola la bala al final del cargador
    }


    method direccionDisparo(posTirador)= self.direccionADisparar(self.posEnemigo(),posTirador)
    
    method direccionADisparar(posEnemigo,posTirador){
            return gestorDireccionBala.direccionDeBala(posEnemigo,posTirador)
        }
            
}

class Bala inherits VisualAtravasable{

    var  property dir = null
    const miArma = escopetaGuardabosques
    const gestorColision = gestorDeColisiones
    const gestorMov = gestorDeMovimiento
    const velocidadBala = 200 
    var sigoSinHerir = false
   
    override method image() = "bala-"+ dir.toString()+".png"

    method disparar(){
        
        gestorMov.moverHaciaSinCambiarImagen(dir, self)
        miArma.recargar(self)
        self.gestionarTrayectoria(dir) // llamado recursivo

    }
        
    method gestionarTrayectoria(direccion){
    /*
        Proposito: la bala se mueve recursivamente hasta que se den las condiciones
        para terminar su recorrido y morir(borrar visual)
    */
         
         if( self.puedeSeguirTrayectoria() ) { 
                gestorMov.moverHaciaSinCambiarImagen(direccion, self)
                game.schedule(velocidadBala, {self.gestionarTrayectoria(direccion)})
            
            }
          else              { 
            self.cicloTerminado()
            }
    }
   method cicloTerminado(){game.removeVisual(self)}
    

    override method interaccion(){
       
        self.objetosDondePenetre().forEach({o => o.atacadoPor(self)})  
        sigoSinHerir = false   
    }

    method objetosDondePenetre() = game.getObjectsIn(self.position()).copyWithout(guardabosques)

    // #########################################################
    // #########################################################

    method daño() = 10

    method puedeSeguirTrayectoria(){       
       return  sigoSinHerir || gestorColision.estaDentroDelTablero(self.position())
    }

    method cambiarImagen(imagen){
        // la bala nunca cambia su imagen pero es necesario este metodo por polimorfismo
    }

  override   method atacadoPor(visual){}
  //necesario por polimorfismo porque podria 
}

    const bala1 = new Bala()
    const bala2 = new Bala()
    const bala3 = new Bala()
    const bala4 = new Bala()
    const bala5 = new Bala()
    const bala6 = new Bala()
    