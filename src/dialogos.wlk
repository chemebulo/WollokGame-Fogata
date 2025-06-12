import visualesExtra.amiga
import enemigos.*

/*
    INVARIANTE DE REPRESENTACION : *LA cantidad de dialogos es un numero par, 
                                    *El primer dialogo es del protagonista
                                    *la lista del dialogo que ira en el escenario debe ser [npcActual, dialogoActual]
                                     donde npcActual: es el npc con el que hablara, el npc debe estar en la lista de visualesEnEscena, véase ejemplo en amiga.
                                     dialogoActual = una lista con string de dialogos
                                    *el dialogo que recibe el escenario es SI O SI la lista[npcActual,dialogo]

*/
// ---------- DIALOGO ESCENARIO INICIAL -------

const dialogoAmiga = ["Donde quedaba la cabaña?","al Norte y luego a la derecja","Dale, ahi vengo","Dale, te espero"]

const dialogoEscenarioInicial = [amiga,dialogoAmiga]

//------------DIALOGOS EN ESCENARIO TEST -----
const dialogoTEST = ["Hola de nuevo","Ya habiamos hablado","Enloqueci verdad?","Si, ya vete"]
const dialogoEscenarioTest = [amiga,dialogoTEST]
//--------------------------------------------

const dialogoCabaña = ["Hola, como va?","Buenas Juan, como va el lugar?","Excelente, me preguntaba si tendria algo de leña","Claro,ahi al lado de la chimenea"]
const dialogoEnCabaña = [guardabosques, dialogoCabaña]