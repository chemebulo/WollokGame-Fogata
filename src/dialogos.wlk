import visualesExtra.amiga
import enemigos.*

/*
    INVARIANTE DE REPRESENTACION : *LA cantidad de dialogos es un numero par, 
                                    *El primer dialogo es del protagonista
                                    *la lista del dialogo que ira en el escenario debe ser [npcActual, dialogoActual]
                                     donde npcActual: es el npc con el que hablara, el npc debe estar en la lista de visualesEnEscena,
                                     el npc entiende xPos(), véase ejemplo en amiga
                                     dialogoActual = una lista con string de dialogos
                                     *el dialogo que recibe el escenario es SI O SI la lista[npcActual,dialogo]

*/
// ---------- DIALOGO ESCENARIO INICIAL -------

const dialogoAmiga = ["Hola, como estas","Bien y tu?","Bien, estamos reimplementando los dialogos","Adios"]

const dialogoEscenarioInicial = [amiga,dialogoAmiga]
//------------DIALOGOS EN ESCENARIO TEST -----

const dialogoTEST = ["Hola de nuevo","Ya habiamos hablado","Enloqueci verdad?","Si, ya vete"]
const dialogoEscenarioTest = [amiga,dialogoTEST]
//--------------------------------------------

const dialogoCabaña = ["Hola señor guardabosques","Hola protagonista","Me da un poco de leña?","Claro tome"]
const dialogoEnCabaña = [guardabosques, dialogoCabaña]