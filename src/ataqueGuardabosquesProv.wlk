import protagonista.*
import enemigos.*
import npcMovimiento.*
import gestores.*
import direccion.*
import visualesExtra.*
import npcEstados.*

/*
    AVISO!!!
    *este archiv es provisorio, quizas se mueva a estadosNPC pero se recomienda que se mantenga aqui de momento
   * El gestorDeDirecciones tiene metodos para indicarle a la bala hacia donde disparar.

   *La bala vive hasta que interactue con un objeto o salga del tablero
   *La bala tambien daña a los lobos
   *La baja jamas ataca al guardabosques


*/
class ArmadoEscopeta inherits Armado(pj=guardabosques,
                                     modoAtaque= new Escopetazo(tirador=guardabosques,enemigo=protagonista),
                                     imagenTemporal="guardabosques-dispara.png"){

    // va a disparar en todo momento, no me importa donde este el prota
    override method puedeAtacarAlEnemigo() = true 
}

class Escopetazo{
  
    const gestorDireccionBala = gestorDeDirecciones
    const tirador 
    const enemigo 
    
    method posPropia() = tirador.position()

    method posEnemigo() = enemigo.position()

    method ataqueArma() {
        const direccion = self.direccionADisparar(self.posEnemigo(),self.posPropia())
        const bala = new Bala(dir=direccion)
        bala.dispararseHacia(direccion)
        game.addVisual(bala) 


    }
    
    method direccionADisparar(posEnemigo,posPropia){
            return gestorDireccionBala.direccionDeBala(posEnemigo,posPropia)
        }
            
}

    

class Bala inherits VisualAtravasable(position = guardabosques.position()){
    // en la posicion guardo esa consulta para que al momento de disparar la bala inicialmente
    //este posicionado donde esta el guardabosques al instanciarse la bala
    const dir
    const gestorColision = gestorDeColisiones
    const velocidadBala = 200
    
    override method image() = "bala-"+dir.toString()+".png"
    
    method dispararseHacia(direccion){
        /*
            La bala se mueve recursivamente hasta que interactue con un visual o salga del tablero
            Al cumplirse alguna de las dos la bala muere
        */
      game.schedule(velocidadBala,{self.seguirHacia(direccion);
                                   self.seguirTrayectoriaSiPuede(direccion) })
     }
    
    method seguirTrayectoriaSiPuede(direccion){
          if(self.puedeSeguirTrayectoria()){
                self.dispararseHacia(direccion)
          }else{ self.muerteBala()}
    }
    


    method muerteBala(){
      
        game.removeVisual(self)
    }

    override method interaccion(){
        self.objetosDondePenetre().forEach({o => o.atacadoPor(self)})
        self.muerteBala()
    }

    method objetosDondePenetre() = game.getObjectsIn(self.position()).copyWithout(guardabosques)

    // #########################################################
    // #########################################################


    method daño() = 10

    method seguirHacia(direccion){ 
        // es codigo repetido pero la bala no necesita cambiar su imagen,
        //por ende no uso el gestorDeMovimiento.Se puede refactorizar agregando 
        //un metodo al gestor que no cambie imagen solo para la bala y mandar mensaje directamente
        self.position(direccion.siguientePosicion(self.position()))
    }

    method puedeSeguirTrayectoria(){
        
        return (gestorColision.estaDentroDelTablero(self.position()))
    }

    method cambiarImagen(imagen){
        // la bala nunca cambia su imagen pero es necesario este metodo por polimorfismo
    }

  override   method atacadoPor(visual){}
  //necesario por polimorfismo porque podria 
}
