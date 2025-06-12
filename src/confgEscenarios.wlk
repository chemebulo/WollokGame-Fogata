import visualesExtra.*
import protagonista.*
import enemigos.*
import escenarios.*
import escenariosMapas.*
import dialogos.*
import eventos.*
import videojuego.*

/*
TEMPLATE CONFIGURADORES:
        
const confg_escenarioNombre = {e => e.visualesEnEscena();
                                    e.mapa();
                                    e.ost();
                                    e.dialogo();  // si no hay dialogos borrar esta linea
                                    e.eventos()}  // si no hay eventos borrar esta linea


  * si no hay dialogos borrar e.dialogo();
  * si no hay eventos borra e.eventos(); 

  IMPORTANTE: Si un escenario va a repetirse en distintos puntos del juego,
              los configuradores deben nombrarse al final con v1,v2,v3 para guiarse
              *tanto dialogos como eventos son LISTAS:
                  e.eventos(persecucionLobo)... MAL!!!
                  e.eventos([persecucionLobo]) ..BIEN!!!
                                    

*/
const confg_inicioJuego = {e =>           
                           e.mapa(mapa_inicioJuego);
                           e.ost(game.sound("inicio_v1.mp3"))}

const confg_EscenarioInicial = {e =>   
                                e.mapa(mapa_escenarioInicial);
                                e.visualesEnEscena( [amiga, carpa, fogata, puertaNorte, protagonista]);
                                e.ost(game.sound("musica-escenarioInicial-v1.mp3"));
                                e.dialogo(dialogoEscenarioInicial)}

const confg_escenarioBifurcacion = {e =>        
                                    e.mapa(mapa_escenarioBifurcacion);
                                    e.visualesEnEscena( [ puertaEste, protagonista]);
                                    e.ost(game.sound("musica-escenarioInicial-v1.mp3"));
                                    e.eventos([])}
      
const confg_escenarioBifurcacion_v2 = {e =>         
                                       e.mapa(mapa_escenarioBifurcacion_v2);
                                       e.visualesEnEscena( [ protagonista,puertaOeste]);
                                       e.ost(game.sound("lobos-atacan.mp3"));
                                       e.eventos([])}

const  confg_escenarioCabañaInicial = {e =>           
                                       e.mapa(mapa_cabañaInicial);
                                       e.visualesEnEscena([guardabosques,protagonista] );
                                       e.ost(game.sound("cabaña.mp3"));
                                       e.dialogo(dialogoEnCabaña);
                                       e.eventos([recojerLeña])}

const confg_escenarioEntradaCabaña = {e => 
                                      e.mapa(mapa_entradaCabaña);
                                      e.visualesEnEscena([cabaña,protagonista,puertaEntradaCabaña] );
                                      e.ost(game.sound("musica-escenarioInicial-v1.mp3"))}

const confg_escenarioEntradaCabaña_v2 = {e => 
                                         e.mapa(mapa_entradaCabaña_v2);
                                         e.visualesEnEscena([cabaña,protagonista, puertaOeste] );
                                         e.ost(game.sound("musica-escenarioInicial-v1.mp3"))}

//-----------DEJAR ABAJO DE TODO ---------
const confg_escenarioTEST = {e =>           
                             e.mapa(mapa_escenarioTest);
                             e.visualesEnEscena( [protagonista,hacha,cueva]);
                             e.ost(game.sound("game-win.mp3"));
                             e.eventos([])}

// #########################################################################################################
// CONFIGURADORES EXCLUSIVOS PARA ESCENARIOS CON DIAPOS, NO REQUIEREN CONFIGURADOR DE ESCEANRIO SIGUIENTE
// #########################################################################################################


const confg_graneroDiapo = {e=> videojuego.estoyEnGranero(true);
                            e.mapa(mapa_inicioJuego);
                            e.ost(game.sound("traicion-granero.mp3"))}