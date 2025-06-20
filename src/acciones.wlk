import enemigos.*
import puertas.*
import visualesExtra.*
import gestores.*

class AccionUnica{  // Pequeñas acciones que realiza el guardabosques en 3 puntos de la historia en los eventos
    const property sujeto        = null
    const property gestorAC      = gestorAccionesGuardabosques
    const property dialogoGestor = gestorDeDialogo
    var accionHecha              = false

    // ============================================================================================================== \\

    method hacerAccion(){ // Se usa el booleano para que haga la accion una sola vez
        if(not accionHecha){
            self.hacer()
            accionHecha = true
        }
    }

    method hacer()

    method esTiempoDeRealizarAccion()
}

// ################################################################################################################# \\

object darSalidaGranero inherits AccionUnica(sujeto = loboEspecial){ // Acción que hace el lobo cuando lo matas
    
    override method hacer(){
        game.addVisual(puertaGranero)
    }    
               
    override method esTiempoDeRealizarAccion(){
        return not sujeto.estaVivo()
    }
}

// ################################################################################################################# \\

object darLaLeña inherits AccionUnica(sujeto = guardabosques){
    
    override method hacer(){ 
        game.addVisual(leña)
    }

    override method esTiempoDeRealizarAccion(){
        return dialogoGestor.terminoElDialogo(sujeto)
    }
}

// ################################################################################################################# \\

object prepararseParaGranero inherits AccionUnica(sujeto = guardabosques){
    
    override method hacer(){
        game.addVisual(puertaEntradaCabaña)
    }
        
    override method esTiempoDeRealizarAccion(){
        return dialogoGestor.terminoElDialogo(sujeto)
    }
}

// ################################################################################################################# \\

object peleaFinalEstado inherits AccionUnica(sujeto = guardabosques) { // Cuidado si cambian nombre, un escenario se llama peleaFinal
     
    override method hacer(){
        game.addVisual(puertaEntradaCueva)
    }    
               
    override method esTiempoDeRealizarAccion(){
        return not sujeto.estaVivo()
    }
}