// Programa para controlar el tiempo de de 2 semáforos con lenguaje de texto estructurado ST


// Primero: Asignación de variables para ambos semáforos

VAR
// Luces del semáforo
Luz_Verde_1: BOOL := TRUE;
Luz_Amarillo_1: BOOL;
Luz_Rojo_1: BOOL;
Luz_Verde_2: BOOL;
Luz_Amarillo_2: BOOL;
Luz_Rojo_2: BOOL := TRUE;

// Asignamos las variables de los temporizadores
// TON es un temporizador que se activa cuando la señal de entrada es TRUE
// y se desactiva cuando la señal de salida es TRUE

// Temporizadores
Timer_Verde_1: TON; // Temporizador luz verde semáforo 1
Timer_Amarillo_1: TON; // Temporizador luz amarilla semáforo 1
Timer_Rojo_1: TON; // Temporizador luz roja semáforo 1
Timer_Verde_2: TON; // Temporizador luz verde semáforo 2
Timer_Amarillo_2: TON; // Temporizador luz amarilla semáforo 2
Timer_Rojo_2: TON; // Temporizador luz roja semáforo 2
END_VAR

// Lógica de los temporizadores
Timer_Verde_1(IN := Luz_Verde_1, PT := T#5s);
Timer_Amarillo_1(IN := Luz_Amarillo_1, PT := T#3s);
Timer_Rojo_1(IN := Luz_Rojo_1, PT := T#2s);
Timer_Verde_2(IN := Luz_Verde_2, PT := T#5s);
Timer_Amarillo_2(IN := Luz_Amarillo_2, PT := T#3s);
Timer_Rojo_2(IN := Luz_Rojo_2, PT := T#2s);

// Lógica de las luces
Luz_Verde_1 := Timer_Verde_1.Q;
Luz_Amarillo_1 := Timer_Amarillo_1.Q;
Luz_Rojo_1 := Timer_Rojo_1.Q;
Luz_Verde_2 := Timer_Verde_2.Q;
Luz_Amarillo_2 := Timer_Amarillo_2.Q;
Luz_Rojo_2 := Timer_Rojo_2.Q;

// Lógica de los semáforos
IF Timer_Verde_1.Q THEN
    Luz_Verde_1 := TRUE;
    Luz_Amarillo_1 := FALSE;
    Luz_Rojo_1 := FALSE;
END_IF;

IF Timer_Amarillo_1.Q THEN
    Luz_Verde_1 := FALSE;
    Luz_Amarillo_1 := TRUE;
    Luz_Rojo_1 := FALSE;
END_IF;

IF Timer_Rojo_1.Q THEN
    Luz_Verde_1 := FALSE;
    Luz_Amarillo_1 := FALSE;
    Luz_Rojo_1 := TRUE;
END_IF;