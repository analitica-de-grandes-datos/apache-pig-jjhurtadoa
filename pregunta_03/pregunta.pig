/*
Pregunta
===========================================================================

Obtenga los cinco (5) valores más pequeños de la 3ra columna.

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/

data = LOAD 'data.tsv' USING PigStorage('\t')
    AS (
            letter:chararray,
            date:chararray,
            num:int
    );

numbers = FOREACH data GENERATE num;
n_ordered = ORDER numbers BY num ASC;
first = LIMIT n_ordered 5;
STORE first INTO 'output' USING PigStorage(',');
