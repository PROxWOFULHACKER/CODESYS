// ==============================================================================
// Control de Puerta Automática con Cilindro/Pistón y Señalización LED
// Lenguaje: Texto Estructurado (Structured Text - ST) / IEC 61131-3 (CODESYS)
// ==============================================================================
// Descripción del ciclo:
// 1. Estado 0 (Reposo): En espera de la activación del interruptor/sensor de presión.
// 2. Estado 1 (Apertura - 5s):
//    - Se enciende la Luz Verde.
//    - El pistón se activa/extiende abriendo la puerta durante 5 segundos.
// 3. Estado 2 (Cierre - 5s):
//    - Se apaga la Luz Verde y se enciende la Luz Roja.
//    - El pistón se contrae cerrando la puerta durante 5 segundos.
// 4. Fin de ciclo: Se apagan las salidas y regresa a reposo.
// ==============================================================================

VAR
    // Entradas
    Interruptor_Presion : BOOL;      // Sensor o pulsador/interruptor de presión

    // Salidas de señalización luminosa (LEDs)
    Luz_Verde           : BOOL;      // Indica funcionamiento / Puerta abriéndose
    Luz_Roja            : BOOL;      // Indica que la puerta se está cerrando

    // Salidas de control del actuador (Pistón / Puerta)
    Piston_Avanzar      : BOOL;      // Señal para extender el pistón (Abrir puerta)
    Piston_Contraer     : BOOL;      // Señal para contraer el pistón (Cerrar puerta)

    // Control de secuencia
    Estado              : INT := 0;  // 0 = Reposo, 1 = Abriendo, 2 = Cerrando

    // Temporizadores (TON)
    Timer_Apertura      : TON;       // Temporizador de 5 segundos para apertura
    Timer_Cierre        : TON;       // Temporizador de 5 segundos para cierre
END_VAR

// ==============================================================================
// LÓGICA DE SECUENCIA (MÁQUINA DE ESTADOS)
// ==============================================================================

CASE Estado OF

    0: // ESTADO DE REPOSO
        Luz_Verde       := FALSE;
        Luz_Roja        := FALSE;
        Piston_Avanzar  := FALSE;
        Piston_Contraer := FALSE;

        // Si se activa el interruptor de presión, inicia el ciclo
        IF Interruptor_Presion THEN
            Estado := 1;
        END_IF;

    1: // ESTADO DE APERTURA (5 SEGUNDOS)
        Luz_Verde       := TRUE;
        Luz_Roja        := FALSE;
        Piston_Avanzar  := TRUE;
        Piston_Contraer := FALSE;

        // Se ejecuta el temporizador de apertura
        Timer_Apertura(IN := TRUE, PT := T#5s);

        // Al cumplirse los 5 segundos, pasar a cerrar la puerta
        IF Timer_Apertura.Q THEN
            Timer_Apertura(IN := FALSE); // Reset del temporizador
            Estado := 2;
        END_IF;

    2: // ESTADO DE CIERRE (5 SEGUNDOS)
        Luz_Verde       := FALSE;
        Luz_Roja        := TRUE;
        Piston_Avanzar  := FALSE;
        Piston_Contraer := TRUE;

        // Se ejecuta el temporizador de cierre
        Timer_Cierre(IN := TRUE, PT := T#5s);

        // Al cumplirse los 5 segundos de cierre, volver al reposo
        IF Timer_Cierre.Q THEN
            Timer_Cierre(IN := FALSE); // Reset del temporizador
            Estado := 0;
        END_IF;

ELSE
    // En caso de cualquier estado no definido, volver a reposo
    Estado := 0;
END_CASE;
