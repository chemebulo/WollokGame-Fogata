import enemigos.*
import protagonista.*

class Evento{
    /*
        ATRIBUTOS:
            *visualQueRealizaEvento : el visual que va a realizar el codigo que se ejecuta en el closure
            *tiempo : el tiempo en milisegundos de loop del evento
            *nombreEvento : string con el nombre del evento
            *bloque: codigo que ejecuta el visualQueRealizaEvento(implementar en la herencia,ver ejemplo en PersecucionLobo),
                     
                     
        METODOS:
            nombreEvento() : nombre que requiere el escenario para finalizar eventos
            iniciarEvento() : metodo que requiere el escenario para iniciar Eventos      

        INSTANCIAS DE EVENTOS: la instancia creada debe pasarse a la lista de eventos en el configuradorEscenarios,
                               el visual o visuales que realizan el evento deben encontrarse 
                               en el escenario(en visualesEnEscena del configuradorEscenarios)                
        
    */
    const visualQueRealizaEvento 
    const tiempo 
    const nombreEvento 
    const bloque  
    method nombreEvento() = nombreEvento
    method iniciarEvento(){
        game.onTick(tiempo,nombreEvento,bloque)
    }

    method visualEnEvento() = visualQueRealizaEvento  
}
//######################################################
        //EVENTOS PARA PERSECUCION DE LOBO
//######################################################

class PersecucionLobo inherits Evento(bloque = {self.visualEnEvento().perseguirAPresa()}){
    /*
        INV.REP: El lobo que realiza el evento y el lobo que esta en la lista de VisualesEnEscena del escenario son el mismo.
                
    */   
    
}  

   
//## Evento para el lobo
const persecucionLoboAgresivo = new PersecucionLobo(
                                     visualQueRealizaEvento=loboAgresivo,
                                      nombreEvento= "Lobo persigue al personaje", 
                                      tiempo = 800
                                      )


//######################################################
        //EVENTOS PARA HABLAR
//######################################################
class EventoHablar inherits Evento(bloque ={game.say(self.visualEnEvento(),self.mensaje())}){
    /*
        
    */
    const mensaje = ""
    method mensaje() = mensaje
}

const ejemploEvento = new EventoHablar(
                                 visualQueRealizaEvento = protagonista,
                                 nombreEvento="Hablar",
                                 tiempo=1000,
                                 mensaje = "Estoy hablando a travez de un evento"
)
