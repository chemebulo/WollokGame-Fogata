import wollok.game.*
import protagonista.*
import direccion.*
import escenarios.*
import visualesDiapositivas.*


object videojuego{
   
    var property escenario = inicioJuego
    const gestorDiapositiva = diapositiva
    var estoyEnPrologo= true
    var property numDiapositiva = 1
    const ostInicioJuego = game.sound("inicio-v1.png")
    

    
    method iniciar(){ 
        ostInicioJuego.play()
        escenario.puestaEnEscena()
    }

    method cambiarEscenario(escenarioNuevo){ // cambia a otro escenario
        escenario.limpiar()
        self.escenario(escenarioNuevo)
        escenario.puestaEnEscena()
        
    }
   

    // ############################### TABLERO ###############################
    
    method tablero(){
         game.width(13)
         game.height(9)
	     game.cellSize(100)
        
    }

    // ############################## CONTROLES ##############################
    
    method controles(){
        keyboard.w().onPressDo({protagonista.mover(arriba)})
        keyboard.a().onPressDo({protagonista.mover(izquierda)})
        keyboard.s().onPressDo({protagonista.mover(abajo)})
        keyboard.d().onPressDo({protagonista.mover(derecha)})
        keyboard.e().onPressDo({protagonista.interactuarNPC()})
        keyboard.f().onPressDo({self.iniciarJuego()})
        keyboard.m().onPressDo({game.stop()})
        


        
    }

    //########## inicio de juego con diapositivas ################

    method iniciarJuego(){
        /*if(inicio){
            if(diapositiva.finalizoFlujo(numDiapositiva)){
                self.culminarPrologoEIniciarJuego()
            }
            else{
                self.continuarFlujoDiapositivas()
            }
        }*/
        if(estoyEnPrologo){
                 gestorDiapositiva.gestionarDiapositivas()
       }
        
    }

    method culminarPrologoEIniciarJuego(){
        /*
            PROPOSITO: Borra las diapositivas en pantalla  e inicia el juego
            Este metodo solo se llama desde el gestor de diapositivas ya que  si lo agrego en iniciarJuego() se ejecutara cada vez que 
            presiono f y rompera todo el juego. Debo pensar en un mejor diseño
        */
        gestorDiapositiva.removerTodo()
        estoyEnPrologo=false
        ostInicioJuego.stop()
        self.cambiarEscenario(escenarioInicial)
    }
    /*

    method continuarFlujoDiapositivas(){
            diapositiva.dibujarDiapositiva()
            numDiapositiva +=1
    }*/

    
}
 

object diapositiva{

    const juego = videojuego
    var estadoDiapositiva = true

    const d0 = new Diapositiva(image="diapo-1.png")
    const d1 = new Diapositiva(image="diapo-2.png")
    const d2 = new Diapositiva(image="diapo-3.png")
    const d3 = new Diapositiva(image="diapo-4.png")
    const d4 = new Diapositiva(image="diapo-5.png")
const d5 = new Diapositiva(image="diapo-6.png")
    const d6 = new Diapositiva(image="diapo-7.png")
    const d7 = new Diapositiva(image="diapo-8.png")
    const d8 = new Diapositiva(image="diapo-9.png")
    const d9 = new Diapositiva(image="diapo-10.png")


   

    const guardar = #{d0,d1,d2,d3,d4,d5,d6,d7,d8,d9}
    const dibujos = [d0,d1,d2,d3,d4,d5,d6,d7,d8,d9]

    method dibujarDiapositiva(){
        game.addVisual(dibujos.first())
        dibujos.remove(dibujos.first())
    }
 
    method ultimaDiapositiva() = 10

    method finalizoFlujo(){
        return juego.numDiapositiva()>self.ultimaDiapositiva()
    }

    method removerTodo(){
        /*
            Cuando dibujo as diapositivas, voy borrando la referencia en la colecccion de dibujos
            dibujos queda vacio por ende debo borrar manualmente las diapositivas
        */
        guardar.forEach({d=>game.removeVisual(d)})
        //guardar.forEach({d=> d=null})
    }

    method gestionarDiapositivas(){
        if(self.finalizoFlujo()){
            juego.culminarPrologoEIniciarJuego()
        }
        else{
            
            self.dibujarDiapositiva()
            self.numDiapositivaAumentar()
        }
    }

    method culminarPrologoEIniciarJuego(){
        self.removerTodo()
        estadoDiapositiva=false
        juego.cambiarEscenario(escenarioInicial)
    }

    method numDiapositivaAumentar(){
        const aumento = juego.numDiapositiva() +1
        juego.numDiapositiva(aumento)
    }

   /* method continuarFlujoDiapositivas(){
            diapositiva.dibujarDiapositiva()
            numDiapositiva +=1
    }*/
}
            
           
