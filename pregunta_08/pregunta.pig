/*
Pregunta
===========================================================================

Para el archivo `data.tsv` compute la cantidad de registros por letra de la 
columna 2 y clave de al columna 3; esto es, por ejemplo, la cantidad de 
registros en tienen la letra `b` en la columna 2 y la clave `jjj` en la 
columna 3 es:

  ((b,jjj), 216)

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/

data = LOAD 'data.tsv' 
    AS (
        c1:chararray, 
        c2:BAG{tup:TUPLE(chararray)},
        c3:MAP[]
       );

tuples = FOREACH data  GENERATE FLATTEN(c2) AS cbag, FLATTEN(c3) AS cmap;
grouped = GROUP tuples BY (cbag, cmap);
counted = FOREACH grouped GENERATE group, COUNT(tuples);

STORE counted INTO 'output' USING PigStorage(',');