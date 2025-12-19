import gestores.*
import protagonista.*

// ################################################################################################################# \\

class MovimientoNPC {
    const direccionesGestor = gestorDeDirecciones   // Representa el gestor de direcciones que utiliza el movimiento.
    const posicionesGestor  = gestorDeCeldasTablero // Representa el gestor de posiciones que utiliza el movimiento.

    // ============================================================================================================= \\

    method perseguirEnemigo(visual, enemigo){
        // Si el NPC no está sobre el enemigo, lo persigue para poder atacarlo.
        if (!visual.estaSobreEnemigo()){ 
            self.avanzarHaciaEnemigo(visual, enemigo) 
        }
    }

    method avanzarHaciaEnemigo(visual, enemigo){
        // Mueve al NPC hacia la siguiente posición y modifica su imagen en base a la dirección a la que se movió (en caso que asi sea).
        const positionAntiguo = visual.position()
        const positionNuevo   = self.siguientePosicion(positionAntiguo, enemigo)
        
        if(positionNuevo != positionAntiguo){ 
           self.irACeldaCercanaAEnemigo(visual, positionNuevo, positionAntiguo)
        }
    }

    method siguientePosicion(position, enemigo){
        // Describe la siguiente posición conveniente para el NPC en base de donde esté parado.
        return posicionesGestor.lindanteConvenienteHacia(position, enemigo)
    }

    method irACeldaCercanaAEnemigo(visual, positionNuevo, positionAntiguo){
        // Mueve al NPC a la posición nueva, cambiando además, la imagen suya dependiendo a donde se movió.
        visual.position(positionNuevo) 
        visual.cambiarImagen(direccionesGestor.direccionALaQueSeMovio(positionAntiguo, positionNuevo))
    }
}

// ################################################################################################################# \\