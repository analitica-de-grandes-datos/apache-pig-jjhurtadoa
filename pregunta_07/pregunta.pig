/*
Pregunta
===========================================================================

Para el archivo `data.tsv` genere una tabla que contenga la primera columna,
la cantidad de elementos en la columna 2 y la cantidad de elementos en la 
columna 3 separados por coma. La tabla debe estar ordenada por las 
columnas 1, 2 y 3.

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/


data = LOAD 'data.tsv' USING PigStorage('\t')
  AS (

        col_1:chararray,
        col_2:bag{t: tuple(p:chararray)},
        col_3:map[]

);

regs =  FOREACH data GENERATE col_1, SIZE(col_2)  AS col_2, SIZE(col_3) AS col_3;
order_cols = ORDER regs BY col_1 ASC, col_2 ASC, col_3 ASC;
STORE order_cols INTO 'output' USING PigStorage (',');