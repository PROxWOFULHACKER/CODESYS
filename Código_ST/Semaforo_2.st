// Programa para controlar el tiempo de de 2 semáforos con lenguaje de texto estructurado ST


// Primero: Asignación de variables para ambos semáforos

VAR
// Luces del semáforo
Luz_Verde_1: BOOL := TRUE;
Luz_Amarillo_1: BOOL;
Luz_Rojo_1: BOOL;

// Asignamos las variables de los temporizadores
// TON es un temporizador que se activa cuando la señal de entrada es TRUE
// y se desactiva cuando la señal de salida es TRUE

// Temporizadores
Timer_Verde_1: TON; // Temporizador luz verde semáforo 1
Timer_Amarillo_1: TON; // Temporizador luz amarilla semáforo 1
Timer_Rojo_1: TON; // Temporizador luz roja semáforo 1
END_VAR

// Lógica de los temporizadores
Timer_Verde_1(IN := Luz_Verde_1, PT := T#5s);
Timer_Amarillo_1(IN := Luz_Amarillo_1, PT := T#3s);
Timer_Rojo_1(IN := Luz_Rojo_1, PT := T#2s);

// Lógica de los semáforos
IF Timer_Verde_1.Q THEN
    Luz_Verde_1 := FALSE;
    Luz_Amarillo_1 := TRUE;
END_IF;

IF Timer_Amarillo_1.Q THEN
    Luz_Amarillo_1 := FALSE;
    Luz_Rojo_1 := TRUE;
END_IF;

IF Timer_Rojo_1.Q THEN
    Luz_Rojo_1 := FALSE;
    Luz_Verde_1 := TRUE;
END_IF;