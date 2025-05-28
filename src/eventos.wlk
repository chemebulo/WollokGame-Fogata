import enemigos.*
//####### EVENTOS DE PERSECUCION DEL LOBO
class PersecucionLobo{
    /*
        INV.REP: El lobo que realiza el evento y el lobo que esta en la lista de VisualesEnEscena del escenario son el mismo
    */
    const animal // el lobo que realiza la accion
    const nombreEvento
    const tiempo // en milisegundos
   

    method nombreEvento() = nombreEvento

    method iniciarEvento(){
        game.onTick(tiempo,nombreEvento,{animal.perseguirAPresaYAtacar()})
    }
}


const persecucionLobo = new PersecucionLobo(
                                      animal = lobo,
                                      nombreEvento= "Lobo persigue al personaje", 
                                      tiempo = 800
                                      )

