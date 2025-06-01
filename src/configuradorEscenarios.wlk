import visualesExtra.*
import protagonista.*
import dialogos.*
import escenarios.*
import escenarios_mapas.*
import enemigos.*
import eventos.*
import guardabosques.*
/*
TEMPLATE CONFIGURADORES:
const confg_escenarioNombre = {e => e.fondoEscenario();           
                                      e.mapa();
                                      e.visualesEnEscena( );
                                      e.ost();
                                      e.dialogo();
                                      e.eventos()}

//BORRAR LOS QUE NO SE USEN, Respetar nomenclatura de variables para no marearse

*/
const confg_inicioJuego= {e => e.fondoEscenario("inicio-v2.png");           
                               e.mapa(mapa_inicioJuego);
                               e.ost(game.sound("inicio_v1.mp3"));
                                      
                         }

const confg_EscenarioInicial = {e => e.fondoEscenario("fondo-escenario-inicial.png");   
                                      e.mapa(mapa_escenarioInicial);
                                      e.visualesEnEscena( [amiga, carpa, fogata, puertaNorte, protagonista]);
                                      e.ost(game.sound("musica-escenarioInicial-v1.mp3"));
                                      e.dialogo(dialogoEscenarioInicial)}


const confg_escenarioBifurcacion = {e => e.fondoEscenario("fondo-escenario-inicial.png");       // borrar luego    
                                      e.mapa(mapa_escenarioBifurcacion);
                                      e.visualesEnEscena( [ puertaEste, protagonista]);
                                      e.ost(game.sound("musica-escenarioInicial-v1.mp3"));
                                     // e.eventos([persecucionLoboAgresivo, persecucionLoboPasivo])} de momento comentado para no romper
                                     e.eventos([])}

const confg_escenarioBifurcacion_v2 = {e => e.fondoEscenario("fondo-escenario-inicial.png");         
                                      e.mapa(mapa_escenarioBifurcacion_v2);
                                      e.visualesEnEscena( [ protagonista,loboAgresivo]);
                                      e.ost(game.sound("lobos-atacan.mp3"));
                                      e.eventos([persecucionLobo])}

                                       

const  confg_escenarioCabañaInicial ={ e => e.fondoEscenario("cabaña.png");           
                                      e.mapa(mapa_cabañaInicial);
                                      e.visualesEnEscena([guardabosques,protagonista] );
                                      e.ost(game.sound("cabaña.mp3"));
                                      e.dialogo(dialogoEnCabaña);
                                      e.eventos([recojerLeña])}


const confg_escenarioEntradaCabaña = {e => e.fondoEscenario("fondo-escenario-inicial.png");           
                                      e.mapa(mapa_entradaCabaña);
                                      e.visualesEnEscena([cabaña,protagonista,puertaEntradaCabaña] );
                                      e.ost(game.sound("musica-escenarioInicial-v1.mp3"));
                                     }

const confg_escenarioEntradaCabaña_v2 = {e => e.fondoEscenario("fondo-escenario-inicial.png");           
                                      e.mapa(mapa_entradaCabaña_v2);
                                      e.visualesEnEscena([cabaña,protagonista,puertaOeste] );
                                      e.ost(game.sound("musica-escenarioInicial-v1.mp3"));
                                     }


//-----------DEJAR ABAJO DE TODO ---------
const confg_escenarioTEST = {e => e.fondoEscenario("fondo-escenarioTEST.png");           
                                      e.mapa(mapa_escenarioTest);
                                      e.visualesEnEscena( [carpa, amiga, protagonista, puertaOeste]);
                                      e.ost(game.sound("musica-escenarioInicial.mp3"));
                                      e.dialogo(dialogoEscenarioTest)
                                     }



                                     