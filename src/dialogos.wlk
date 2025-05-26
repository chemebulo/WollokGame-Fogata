/*
    LOS DIALOGOS ENTRE EL PROTAGONISTA Y LOS NPC SERAN COLECCIONES MAP:
        * Cada objeto diálogo será entre el protagonista y un NPC y solo funciona en el escenario actual.
        * Cada conversacion entiende inicializar() y dialogoFinal()
*/

object amigaConversacion{

    method inicializar(){
        const charlaAmiga = new Dictionary()

        charlaAmiga.put(1,"Hola como estas")
        charlaAmiga.put(2,"Bien y vos")
        charlaAmiga.put(3,"Tambien, hace demasiado calor no?")
        charlaAmiga.put(4,"Si, la fogata parece que se va a apagar en cualquier momento")
        charlaAmiga.put(5,"Si eso pasa voy a buscar leña")
        charlaAmiga.put(6,"Y donde vas a conseguir?")
        charlaAmiga.put(7,"En la cabaña que alquilamos")
        charlaAmiga.put(8,"Sabes el camino?")
        charlaAmiga.put(9,"Si, al norte")
        charlaAmiga.put(10,"uy, se acaba de apagar el fuego")
        charlaAmiga.put(11,"Bueno, ahi busco") // Aca termina. 

        return charlaAmiga
    }

    method dialogoFinal() = 11 // Si la conversación termina siempre se dirá el ultimo dialogo si se vuelve a interactuar.
}