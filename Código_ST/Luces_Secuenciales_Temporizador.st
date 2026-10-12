// ==============================================================================
// Control Secuencial: Luz Verde (5s) -> Luz Roja (5s) -> Apagado
// Lenguaje: Texto Estructurado (Structured Text - ST) / IEC 61131-3 (CODESYS)
// ==============================================================================
// Funcionamiento:
// 1. Al activar el interruptor/pulsador, se enciende la LUZ VERDE y arranca su
// temporizador/contador de tiempo de 5 segundos.
// 2. Al cumplirse los 5 segundos de verde, se apaga la LUZ VERDE y se enciende
// la LUZ ROJA activando el segundo temporizador de 5 segundos.
// 3. Al finalizar los 5 segundos de rojo, la LUZ ROJA se apaga y el sistema
// queda en reposo esperando una nueva activación.
// ==============================================================================

VAR
    // Entrada
    Interruptor: BOOL; // Interruptor o pulsador de activación

    // Salidas
    Luz_Verde: BOOL; // Luz verde
    Luz_Roja: BOOL; // Luz roja

    // Control de ciclo
    Ciclo_Activo: BOOL; // Bandera que mantiene el ciclo en marcha tras pulsar

    // Temporizadores (Contadores de tiempo IEC 61131-3)
    Timer_Verde: TON; // Temporizador para luz verde (5 segundos)
    Timer_Rojo: TON; // Temporizador para luz roja (5 segundos)

    // Opcional: Visualización del tiempo transcurrido en segundos (0 a 5)
    Segundos_Verde: INT; // Conteo actual en segundos de la luz verde
    Segundos_Rojo: INT; // Conteo actual en segundos de la luz roja
END_VAR

// ------------------------------------------------------------------------------
// 1. Detección de inicio de ciclo
// ------------------------------------------------------------------------------
IF Interruptor AND NOT Ciclo_Activo THEN
    Ciclo_Activo := TRUE;
    Luz_Verde := TRUE;
    Luz_Roja := FALSE;
END_IF;

// ------------------------------------------------------------------------------
// 2. Primer temporizador (Luz Verde durante 5 segundos)
// ------------------------------------------------------------------------------
Timer_Verde(IN := (Ciclo_Activo AND Luz_Verde), PT := T#5s);

// Conversión del tiempo actual transcurrido a número entero de segundos
Segundos_Verde := TIME_TO_INT(Timer_Verde.ET / 1000);

// Al terminar los 5 segundos de la luz verde:
IF Timer_Verde.Q THEN
    Luz_Verde := FALSE; // Apagar luz verde
    Luz_Roja := TRUE; // Encender luz roja y dar paso al segundo temporizador
END_IF;

// ------------------------------------------------------------------------------
// 3. Segundo temporizador (Luz Roja durante 5 segundos)
// ------------------------------------------------------------------------------
Timer_Rojo(IN := (Ciclo_Activo AND Luz_Roja), PT := T#5s);

// Conversión del tiempo actual transcurrido a número entero de segundos
Segundos_Rojo := TIME_TO_INT(Timer_Rojo.ET / 1000);

// Al terminar los 5 segundos de la luz roja:
IF Timer_Rojo.Q THEN
    Luz_Roja := FALSE; // Se apaga la luz roja
    Ciclo_Activo := FALSE; // Fin del ciclo completo, regresa a reposo
END_IF;
