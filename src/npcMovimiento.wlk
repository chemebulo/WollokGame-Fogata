import gestores.*
import protagonista.*

class MovimientoNPC {
    const colisionesGestor  = gestorDeColisiones  // Representa el gestor de colisiones.
    const direccionesGestor = gestorDeDirecciones // Representa el gestor de direcciones.
    const posicionesGestor  = gestorDePosiciones  // Representa el gestor de posiciones.
    const npc                                     // Representa al NPC que realiza el movimiento.
    const enemigo = protagonista                  // Representa al enemigo que tiene el NPC.

    // ============================================================================================================= \\

    method perseguirEnemigo(){
        // Hace que el NPC persiga a su enemigo para poder atacarlo.
        if (npc.puedeAtacarAlEnemigo()) { npc.atacarEnemigo() } else
        if (not npc.estaSobreEnemigo()) { self.avanzarHaciaEnemigo() }
    }

    method avanzarHaciaEnemigo(){
        // Mueve al NPC hacia la siguiente posición y modifica su imagen en base a la dirección a la que se movió.
        const positionAntigua = npc.position()
        const positionNuevo   = self.siguientePosicion()

        if(not colisionesGestor.hayObstaculoEn(positionNuevo, enemigo)) {
            npc.position(positionNuevo) 
            npc.cambiarImagen(direccionesGestor.direccionALaQueSeMovio(positionAntigua, positionNuevo))
        }
    }
    
    method siguientePosicion(){
        // Describe la siguiente posición conveniente para el NPC en base de donde esté parado.
        return posicionesGestor.lindanteConvenienteHacia(npc.position(), enemigo)
    }
}