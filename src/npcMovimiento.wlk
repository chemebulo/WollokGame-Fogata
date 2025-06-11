import gestores.*
import protagonista.*

class MovimientoNPC {
    const colisionesGestor  = gestorDeColisiones  //
    const direccionesGestor = gestorDeDirecciones //
    const posicionesGestor  = gestorDePosiciones  //
    const visual                                  //
    const enemigo = protagonista                  //

    // ============================================================================================================= \\

    method perseguirEnemigo(){
        //
        if (visual.puedeAtacarAlEnemigo()) { visual.atacarEnemigo() } else 
                                           { self.avanzarHaciaEnemigo() }
    }

    method avanzarHaciaEnemigo(){
        //
        const positionAntigua = visual.position()
        const positionNuevo   = self.siguientePosicion()

        if(not colisionesGestor.hayObstaculoEn(positionNuevo, enemigo)) {
            visual.position(positionNuevo) 
            visual.cambiarImagen(direccionesGestor.direccionALaQueSeMovio(positionAntigua, positionNuevo))
        }
    }
    
    method siguientePosicion(){
        //
        return posicionesGestor.lindanteConvenienteHacia(visual.position(), enemigo)
    }
}