// Pruebas de la impresora Amstrad DMP-2000 desde el ZX Spectrum +2A/+3 (+3 BASIC, LPRINT).
// FORMAT LPRINT "C" manda LPRINT al puerto paralelo y "U" lo deja sin expandir (los codigos de control y los bytes 128-255
// llegan tal cual). Cada linea acaba con c$ (CR + LF) y un ";" para que el ROM no anada su propio salto de linea.
#pragma target plus3
FORMAT LPRINT "C": FORMAT LPRINT "U"
LET e$=CHR$ 27: LET c$=CHR$ 13+CHR$ 10
@menu:
CLS
PRINT "DMP-2000: pruebas de impresion"
PRINT
PRINT "1 Tipos de letra 6 Graficos"
PRINT "2 Funciones      7 Definidos"
PRINT "3 Internacional  8 Tampon"
PRINT "4 Interlinea     9 Pagina y VT"
PRINT "5 Margenes, tabs 10 Octavo bit"
PRINT "0 Todas"
INPUT "Prueba (0-10)? ";op
IF op<0 OR op>10 THEN GO TO @menu
IF op=0 THEN FOR t=1 TO 10: GO SUB @hacer : NEXT t
IF op>0 THEN LET t=op: GO SUB @hacer
PRINT "Hecho. En RVM3, F4 abre la impresion"
PAUSE 0
GO TO @menu

@hacer:
PRINT "Imprimiendo prueba ";t
LPRINT e$;"@";
IF t=1 THEN GO SUB @tipos
IF t=2 THEN GO SUB @funciones
IF t=3 THEN GO SUB @paises
IF t=4 THEN GO SUB @interlinea
IF t=5 THEN GO SUB @margenes
IF t=6 THEN GO SUB @graficos
IF t=7 THEN GO SUB @definidos
IF t=8 THEN GO SUB @tampon
IF t=9 THEN GO SUB @pagina
IF t=10 THEN GO SUB @octavo
LPRINT c$;
RETURN

@tipos:
LPRINT "== 1. TIPOS DE LETRA ==";c$;
LPRINT "Pica (10 cpp): The quick brown fox jumps over the lazy dog 0123456789";c$;
LPRINT e$;"M";"Mini/Elite (12 cpp): The quick brown fox jumps over the lazy dog";e$;"P";c$;
LPRINT CHR$ 15;"Estrecha (17 cpp): The quick brown fox jumps over the lazy dog 0123456789";CHR$ 18;c$;
LPRINT e$;"p";CHR$ 1;"Proporcional: The quick brown fox jumps over the lazy dog. iiii mmmm";e$;"p";CHR$ 0;c$;
LPRINT e$;"x";CHR$ 1;"NLQ (alta calidad): The quick brown fox jumps over the lazy dog";c$;
LPRINT e$;"p";CHR$ 1;"NLQ proporcional: The quick brown fox jumps over the lazy dog";e$;"p";CHR$ 0;e$;"x";CHR$ 0;c$;
RETURN

@funciones:
LPRINT "== 2. FUNCIONES ==";c$;
LPRINT "Normal, ";e$;"E";"negra (ESC E)";e$;"F";", ";e$;"G";"doble impresion (ESC G)";e$;"H";c$;
LPRINT e$;"4";"Cursiva (ESC 4) The quick brown fox";e$;"5";" y ";e$;"-";CHR$ 1;"subrayado (ESC -)";e$;"-";CHR$ 0;c$;
LPRINT e$;"W";CHR$ 1;"Doble anchura";e$;"W";CHR$ 0;" (ESC W)";c$;
LPRINT CHR$ 14;"SO una linea";CHR$ 20;" y DC4 lo corta";c$;
LPRINT "Subindices: H";e$;"S";CHR$ 1;"2";e$;"T";"O  Superindices: E=mc";e$;"S";CHR$ 0;"2";e$;"T";c$;
LPRINT e$;"x";CHR$ 1;e$;"4";"NLQ cursiva";e$;"5";" ";e$;"E";"NLQ negra";e$;"F";e$;"x";CHR$ 0;c$;
FOR m=0 TO 7
LET b=2^m
LPRINT e$;"!";CHR$ b;"ESC ! ";b;": The quick brown fox";e$;"!";CHR$ 0;c$;
NEXT m
LPRINT e$;"!";CHR$ (8+32+64);"ESC ! 104: negra + ancha + cursiva";e$;"!";CHR$ 0;c$;
RETURN

@paises:
LPRINT "== 3. JUEGOS INTERNACIONALES (ESC R) ==";c$;
RESTORE @paisdata
FOR n=0 TO 8
READ p$
LPRINT e$;"R";CHR$ n;"R";n;" ";p$;": # $ @ [ \\ ] ^ ";CHR$ 96;" { | } ~";e$;"R";CHR$ 0;c$;
NEXT n
RETURN
@paisdata:
DATA "EE.UU.","Francia","Alemania","Reino Unido","Dinamarca","Suecia","Italia","Espana","Japon"

@interlinea:
LPRINT "== 4. INTERLINEA ==";c$;
LPRINT e$;"0";
FOR i=1 TO 3: LPRINT "Interlinea 1/8 pulgada (ESC 0), linea ";i;c$;: NEXT i
LPRINT e$;"1";
FOR i=1 TO 3: LPRINT "Interlinea 7/72 (ESC 1), linea ";i;c$;: NEXT i
LPRINT e$;"3";CHR$ 48;
FOR i=1 TO 3: LPRINT "Interlinea 48/216 (ESC 3 48), linea ";i;c$;: NEXT i
LPRINT e$;"A";CHR$ 18;
FOR i=1 TO 3: LPRINT "Interlinea 18/72 (ESC A 18), linea ";i;c$;: NEXT i
LPRINT e$;"2";
LPRINT "Avance de 72/216 con ESC J ->";e$;"J";CHR$ 72;"<- aqui sigue";c$;
LPRINT "XXXXXXXXXXXXXXXXXXXX";c$;
LPRINT e$;"j";CHR$ 36;"--------------------  (retroceso ESC j 36)";c$;
RETURN

@margenes:
LPRINT "== 5. MARGENES Y TABULADORES ==";c$;
LPRINT e$;"l";CHR$ 10;e$;"Q";CHR$ 50;
LPRINT "Este parrafo tiene margen izquierdo 10 y derecho 50 (ESC l, ESC Q), ";
LPRINT "asi que al llegar al margen la impresora pasa sola a la linea siguiente.";c$;
LPRINT e$;"l";CHR$ 0;e$;"Q";CHR$ 80;
LPRINT "Tab por defecto:";CHR$ 9;"a";CHR$ 9;"b";CHR$ 9;"c";c$;
LPRINT e$;"D";CHR$ 5;CHR$ 20;CHR$ 40;CHR$ 0;
LPRINT "0";CHR$ 9;"5";CHR$ 9;"20";CHR$ 9;"40  (ESC D 5 20 40)";c$;
LPRINT "Sobreimpresion con BS: O";CHR$ 8;"/  =";CHR$ 8;"/  E";CHR$ 8;"_";c$;
RETURN

@graficos:
LPRINT "== 6. GRAFICOS ==";c$;
RESTORE @gdata
FOR g=1 TO 4
READ k$,d
LPRINT "ESC ";k$;" ";d;" ppp: ";e$;k$;CHR$ 120;CHR$ 0;
FOR i=0 TO 119: LPRINT CHR$ (2^(i-7*INT (i/7)));: NEXT i
LPRINT c$;
NEXT g
FOR m=0 TO 6
LPRINT "ESC * modo ";m;": ";e$;"*";CHR$ m;CHR$ 80;CHR$ 0;
FOR i=0 TO 79: LPRINT CHR$ (42+43*(i-2*INT (i/2)));: NEXT i
LPRINT c$;
NEXT m
LPRINT "ESC ? K 3 (K a 240 ppp): ";e$;"?";"K";CHR$ 3;e$;"K";CHR$ 120;CHR$ 0;
FOR i=0 TO 119: LPRINT CHR$ 127;: NEXT i
LPRINT e$;"?";"K";CHR$ 0;c$;
RETURN
@gdata:
DATA "K",60,"L",120,"Y",120,"Z",240

@definidos:
LPRINT "== 7. CARACTERES DEFINIDOS (ESC :, ESC &, ESC %, ESC I) ==";c$;
LPRINT e$;":";CHR$ 0;CHR$ 0;CHR$ 0;
LPRINT e$;"&";CHR$ 0;CHR$ 65;CHR$ 65;CHR$ 11;
RESTORE @udg
FOR d=1 TO 11: READ v: LPRINT CHR$ v;: NEXT d
LPRINT e$;"%";CHR$ 1;CHR$ 0;"Con el juego definible la A es un cuadro: ABRACADABRA";e$;"%";CHR$ 0;CHR$ 0;c$;
LPRINT e$;"I";CHR$ 1;"Codigos 1-6 impresos con ESC I 1: ";CHR$ 1;CHR$ 2;CHR$ 3;CHR$ 4;CHR$ 5;CHR$ 6;e$;"I";CHR$ 0;c$;
RETURN
@udg:
DATA BIN 1111111,0,BIN 1000001,0,BIN 1000001,0,BIN 1000001,0,BIN 1000001,0,BIN 1111111

@tampon:
LPRINT "== 8. TAMPON Y CONTROL ==";c$;
LPRINT "Borrado con DEL: ABCX";CHR$ 127;"D (debe salir ABCD)";c$;
LPRINT "Esto no debe salir";CHR$ 24;"CAN borra el tampon: solo sale esto";c$;
LPRINT "Pitido (BEL)";CHR$ 7;c$;
LPRINT e$;"U";CHR$ 1;"Unidireccional (ESC U 1)";e$;"U";CHR$ 0;c$;
LPRINT e$;"s";CHR$ 1;"Media velocidad (ESC s 1)";e$;"s";CHR$ 0;c$;
RETURN

@pagina:
LPRINT "== 9. PAGINA Y TABULACION VERTICAL ==";c$;
LPRINT "FF: lo siguiente va al principio de una hoja nueva";CHR$ 12;
LPRINT e$;"B";CHR$ 4;CHR$ 8;CHR$ 0;
LPRINT "Principio de hoja (topes verticales en 4 y 8 con ESC B)";c$;
LPRINT CHR$ 11;"VT: linea 4";c$;
LPRINT CHR$ 11;"VT: linea 8";c$;
LPRINT e$;"b";CHR$ 1;CHR$ 14;CHR$ 0;e$;"/";CHR$ 1;
LPRINT CHR$ 11;"VT por el canal 1 (ESC b 1 14, ESC / 1): linea 14";e$;"/";CHR$ 0;c$;
LPRINT e$;"C";CHR$ 20;e$;"N";CHR$ 3;
FOR i=1 TO 30: LPRINT "Pagina de 20 lineas, salto de 3 (ESC C 20, ESC N 3): linea ";i;c$;: NEXT i
LPRINT e$;"@";CHR$ 12;
RETURN

@octavo:
LPRINT "== 10. OCTAVO BIT (solo con puerto de 8 bits) ==";c$;
LPRINT e$;"!";CHR$ 128;"ESC ! 128: subrayado";e$;"!";CHR$ 0;c$;
LPRINT "Codigos 160-254 (cursiva): ";
FOR i=193 TO 218: LPRINT CHR$ i;: NEXT i
LPRINT c$;
LPRINT e$;"6";"ESC 6, codigos 128-159: ";
FOR i=128 TO 159: LPRINT CHR$ i;: NEXT i
LPRINT e$;"7";c$;
LPRINT e$;">";"ESC > (octavo bit a 1): abcdefg";e$;"#";c$;
LPRINT e$;"=";"ESC = (octavo bit a 0): ";CHR$ 193;CHR$ 194;CHR$ 195;e$;"#";c$;
LPRINT "ESC K con las 8 agujas: ";e$;"K";CHR$ 120;CHR$ 0;
FOR i=0 TO 119: LPRINT CHR$ (2^(i-8*INT (i/8)));: NEXT i
LPRINT c$;
LPRINT "ESC ^ 9 agujas: ";e$;"^";CHR$ 0;CHR$ 60;CHR$ 0;
FOR i=0 TO 59: LPRINT CHR$ 255;CHR$ 128;: NEXT i
LPRINT c$;
LPRINT e$;":";CHR$ 0;CHR$ 0;CHR$ 0;
LPRINT e$;"&";CHR$ 0;CHR$ 66;CHR$ 66;CHR$ 139;
RESTORE @udg
FOR d=1 TO 11: READ v: LPRINT CHR$ v;: NEXT d
LPRINT e$;"%";CHR$ 1;CHR$ 0;"B definida con atributo de 8 bits (agujas de arriba): ABBA";e$;"%";CHR$ 0;CHR$ 0;c$;
RETURN
