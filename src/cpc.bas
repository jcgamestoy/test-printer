// Pruebas de la impresora Amstrad DMP-2000 desde el CPC (Locomotive BASIC, PRINT #8).
// El puerto de impresora del CPC es de 7 bits: no se pueden mandar codigos 128-255, asi que ni ESC ! 128 (subrayado),
// ni el bit 7 de los graficos, ni el atributo de 8 bits de los caracteres definidos.
MODE 2: WIDTH 255
e$=CHR$(27)
@menu:
CLS
PRINT "Amstrad DMP-2000: pruebas de impresion (CPC)"
PRINT
PRINT "1 Tipos de letra          6 Graficos"
PRINT "2 Funciones               7 Caracteres definidos"
PRINT "3 Juegos internacionales  8 Tampon y control"
PRINT "4 Interlinea              9 Pagina y tabulacion vertical"
PRINT "5 Margenes y tabuladores  0 Todas"
PRINT
INPUT "Prueba (0-9)";op
IF op<0 OR op>9 THEN GOTO @menu
IF op=0 THEN FOR t=1 TO 9: GOSUB @hacer: NEXT ELSE t=op: GOSUB @hacer
PRINT "Hecho. En RVM3, F4 abre la impresion."
PRINT "Pulsa una tecla": CALL &BB18
GOTO @menu

@hacer:
PRINT "Imprimiendo prueba";t
PRINT #8,e$;"@";
ON t GOSUB @tipos,@funciones,@paises,@interlinea,@margenes,@graficos,@definidos,@tampon,@pagina
PRINT #8
RETURN

@tipos:
PRINT #8,"== 1. TIPOS DE LETRA =="
PRINT #8,"Pica (10 cpp): The quick brown fox jumps over the lazy dog 0123456789"
PRINT #8,e$;"M";"Mini/Elite (12 cpp): The quick brown fox jumps over the lazy dog";e$;"P"
PRINT #8,CHR$(15);"Estrecha (17 cpp): The quick brown fox jumps over the lazy dog 0123456789";CHR$(18)
PRINT #8,e$;"p";CHR$(1);"Proporcional: The quick brown fox jumps over the lazy dog. iiii mmmm";e$;"p";CHR$(0)
PRINT #8,e$;"x";CHR$(1);"NLQ (alta calidad): The quick brown fox jumps over the lazy dog"
PRINT #8,e$;"p";CHR$(1);"NLQ proporcional: The quick brown fox jumps over the lazy dog";e$;"p";CHR$(0);e$;"x";CHR$(0)
RETURN

@funciones:
PRINT #8,"== 2. FUNCIONES =="
PRINT #8,"Normal, ";e$;"E";"negra (ESC E)";e$;"F";", ";e$;"G";"doble impresion (ESC G)";e$;"H"
PRINT #8,e$;"4";"Cursiva (ESC 4) The quick brown fox";e$;"5";" y ";e$;"-";CHR$(1);"subrayado (ESC -)";e$;"-";CHR$(0)
PRINT #8,e$;"W";CHR$(1);"Doble anchura";e$;"W";CHR$(0);" (ESC W)"
PRINT #8,CHR$(14);"SO una linea";CHR$(20);" y DC4 lo corta"
PRINT #8,"Subindices: H";e$;"S";CHR$(1);"2";e$;"T";"O  Superindices: E=mc";e$;"S";CHR$(0);"2";e$;"T";" 10";e$;"S";CHR$(0);"-3";e$;"T"
PRINT #8,e$;"x";CHR$(1);e$;"4";"NLQ cursiva";e$;"5";" ";e$;"E";"NLQ negra";e$;"F";e$;"x";CHR$(0)
FOR m=0 TO 6
b=2^m
PRINT #8,e$;"!";CHR$(b);"ESC ! ";b;": The quick brown fox";e$;"!";CHR$(0)
NEXT
PRINT #8,e$;"!";CHR$(8+32+64);"ESC ! 104: negra + ancha + cursiva";e$;"!";CHR$(0)
RETURN

@paises:
PRINT #8,"== 3. JUEGOS INTERNACIONALES (ESC R) =="
RESTORE @paisdata
FOR n=0 TO 8
READ p$
PRINT #8,e$;"R";CHR$(n);"R";n;" ";p$;": # $ @ [ \ ] ^ ` { | } ~";e$;"R";CHR$(0)
NEXT
RETURN
@paisdata:
DATA EE.UU.,Francia,Alemania,Reino Unido,Dinamarca,Suecia,Italia,Espana,Japon

@interlinea:
PRINT #8,"== 4. INTERLINEA =="
PRINT #8,e$;"0";
FOR i=1 TO 3: PRINT #8,"Interlinea 1/8 pulgada (ESC 0), linea";i: NEXT
PRINT #8,e$;"1";
FOR i=1 TO 3: PRINT #8,"Interlinea 7/72 (ESC 1), linea";i: NEXT
PRINT #8,e$;"3";CHR$(48);
FOR i=1 TO 3: PRINT #8,"Interlinea 48/216 (ESC 3 48), linea";i: NEXT
PRINT #8,e$;"A";CHR$(18);
FOR i=1 TO 3: PRINT #8,"Interlinea 18/72 (ESC A 18), linea";i: NEXT
PRINT #8,e$;"2";
PRINT #8,"Avance de 72/216 con ESC J ->";e$;"J";CHR$(72);"<- aqui sigue"
PRINT #8,"XXXXXXXXXXXXXXXXXXXX"
PRINT #8,e$;"j";CHR$(36);"--------------------  (retroceso ESC j 36: entre las dos lineas)"
RETURN

@margenes:
PRINT #8,"== 5. MARGENES Y TABULADORES =="
PRINT #8,e$;"l";CHR$(10);e$;"Q";CHR$(50);
PRINT #8,"Este parrafo tiene margen izquierdo 10 y derecho 50 (ESC l, ESC Q), asi que al llegar al margen la impresora pasa sola a la linea siguiente."
PRINT #8,e$;"l";CHR$(0);e$;"Q";CHR$(80);
PRINT #8,"Tab por defecto:";CHR$(9);"a";CHR$(9);"b";CHR$(9);"c"
PRINT #8,e$;"D";CHR$(5);CHR$(20);CHR$(40);CHR$(0);
PRINT #8,"0";CHR$(9);"5";CHR$(9);"20";CHR$(9);"40  (ESC D 5 20 40)"
PRINT #8,"Sobreimpresion con BS: O";CHR$(8);"/  =";CHR$(8);"/  E";CHR$(8);"_"
RETURN

@graficos:
PRINT #8,"== 6. GRAFICOS =="
RESTORE @gdata
FOR g=1 TO 4
READ c$,d
PRINT #8,"ESC ";c$;" ";d;"ppp: ";e$;c$;CHR$(120);CHR$(0);
FOR i=0 TO 119: PRINT #8,CHR$(2^(i MOD 7));: NEXT
PRINT #8
NEXT
FOR m=0 TO 6
PRINT #8,"ESC * modo";m;": ";e$;"*";CHR$(m);CHR$(80);CHR$(0);
FOR i=0 TO 79: PRINT #8,CHR$(42+43*(i MOD 2));: NEXT
PRINT #8
NEXT
PRINT #8,"ESC ? K 3 (K a 240 ppp): ";e$;"?";"K";CHR$(3);e$;"K";CHR$(120);CHR$(0);
FOR i=0 TO 119: PRINT #8,CHR$(127);: NEXT
PRINT #8,e$;"?";"K";CHR$(0)
PRINT #8,"ESC ^ 9 agujas: ";e$;"^";CHR$(0);CHR$(60);CHR$(0);
FOR i=0 TO 59: PRINT #8,CHR$(2^(i MOD 7));CHR$(0);: NEXT
PRINT #8
RETURN
@gdata:
DATA K,60,L,120,Y,120,Z,240

@definidos:
PRINT #8,"== 7. CARACTERES DEFINIDOS (ESC :, ESC &, ESC %, ESC I) =="
PRINT #8,e$;":";CHR$(0);CHR$(0);CHR$(0);
PRINT #8,e$;"&";CHR$(0);CHR$(65);CHR$(65);CHR$(11);
RESTORE @udg
FOR d=1 TO 11: READ v$: PRINT #8,CHR$(VAL("&X"+v$));: NEXT
PRINT #8,e$;"%";CHR$(1);CHR$(0);"Con el juego definible la A es un cuadro: ABRACADABRA";e$;"%";CHR$(0);CHR$(0)
PRINT #8,e$;"I";CHR$(1);"Codigos 1-6 impresos con ESC I 1: ";CHR$(1);CHR$(2);CHR$(3);CHR$(4);CHR$(5);CHR$(6);e$;"I";CHR$(0)
RETURN
@udg:
DATA 1111111,0000000,1000001,0000000,1000001,0000000,1000001,0000000,1000001,0000000,1111111

@tampon:
PRINT #8,"== 8. TAMPON Y CONTROL =="
PRINT #8,"Borrado con DEL: ABCX";CHR$(127);"D (debe salir ABCD)"
PRINT #8,"Esto no debe salir";CHR$(24);"CAN borra el tampon: solo sale esto"
PRINT #8,"Pitido (BEL)";CHR$(7)
PRINT #8,e$;"U";CHR$(1);"Unidireccional (ESC U 1)";e$;"U";CHR$(0)
PRINT #8,e$;"s";CHR$(1);"Media velocidad (ESC s 1)";e$;"s";CHR$(0)
RETURN

@pagina:
PRINT #8,"== 9. PAGINA Y TABULACION VERTICAL =="
PRINT #8,"FF: lo siguiente va al principio de una hoja nueva";CHR$(12);
PRINT #8,e$;"B";CHR$(4);CHR$(8);CHR$(0);
PRINT #8,"Principio de hoja (topes verticales en 4 y 8 con ESC B)"
PRINT #8,CHR$(11);"VT: linea 4"
PRINT #8,CHR$(11);"VT: linea 8"
PRINT #8,e$;"b";CHR$(1);CHR$(14);CHR$(0);e$;"/";CHR$(1);
PRINT #8,CHR$(11);"VT por el canal 1 (ESC b 1 14, ESC / 1): linea 14";e$;"/";CHR$(0)
PRINT #8,e$;"C";CHR$(20);e$;"N";CHR$(3);
FOR i=1 TO 30: PRINT #8,"Pagina de 20 lineas con salto de 3 (ESC C 20, ESC N 3): linea";i: NEXT
PRINT #8,e$;"@";CHR$(12);
RETURN
