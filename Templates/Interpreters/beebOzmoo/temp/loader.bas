*FX229,1
*FX4,1
ON ERROR PROCa
A%=&85:X%=135:b=(USR&FFF4 AND &FFFF00) DIV &100
IF b=&8000 AND HIMEM<&8000 THEN MODE 135:CHAIN "LOADER"
VDU 23,16,0,254,0;0;0;
c=&409
d=&40A
e=&40B
DIM f% 256
PROCg
h=b=&8000
i=PAGE<&E00
IF i THEN PROCj
A%=0:X%=1:k=(USR&FFF4 AND &FF00) DIV &100:l=k=0
MODE 135:VDU 23,1,0;0;0;0;
?c=7:?d=0
IF l THEN VDU 19,0,?d,0;0,19,7,?c,0;0
IF l THEN PROCm ELSE PROCn
o=&87:p=&83:q=&83:r=&81:s=0
IF l THEN o=0:p=0:s=32
PRINT CHR$p;"Hardware detected:"
t=VPOS
IF i THEN PRINT CHR$o;"  Second processor (";u$;")"
IF h THEN PRINT CHR$o;"  Shadow RAM"
IF v$<>"" THEN PRINT CHR$o;"  ";v$
IF t=VPOS THEN PRINT CHR$o;"  None"
PRINT
w=VPOS
PROCx
IF i OR h THEN PROCy ELSE ?e=7+l:z=VPOS:PROCab:PROCbb:REPEAT UNTIL FNcb(GET)
IF ?e=7 THEN ?c=6
PRINTTAB(0,db);CHR$o;"Loading, please wait...                ";
IF i THEN */:0.$.CACHE2P
eb=FNeb
IF eb<>4 THEN fb$=FNfb
IF eb=5 THEN *DIR
ON ERROR GOTO 1000
IF eb=4 THEN PROCgb("DIR S") ELSE *DIR SAVES
1000ON ERROR PROCa
IF eb=4 THEN hb$="/"+ib$ ELSE hb$=fb$+".DATA"
IF LENhb$>=49 THEN PROCjb("Game data path too long")
kb=&42F
$kb=hb$
*FX4,0
IF eb=4 THEN PROCgb($kb) ELSE PROCgb("/"+fb$+"."+ib$)
END
DEF PROCa:CLS:REPORT:PRINT" at line ";ERL:PROClb
DEF PROCjb(mb$)
VDU 28,0,db,39,w,12
PROCnb(o,mb$)
PRINT
DEF PROClb
*FX229,0
*FX4,0
END
DEF PROCm
VDU 23,128,0;0,255,255,0,0;
PRINTTAB(0,23);STRING$(40,CHR$128);"Powered by Ozmoo 4.4 (Acorn 2021-02-18)";
IF POS=0 THEN VDU 30,11 ELSE VDU 30
PRINT "dust";:IF POS>0 THEN PRINT
PRINTSTRING$(40,CHR$128);
PRINT "https://ikeserver.de/Dust";:IF POS>0 THEN PRINT
PRINT:db=22
ENDPROC
DEF PROCn
PRINTTAB(0,21);:PRINT
PRINT
PRINTCHR$147;",,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,";
PRINTCHR$131;"Powered by Ozmoo 4.4 (Acorn 2021-02-18)";
IF POS=0 THEN VDU 30,11 ELSE VDU 30
PRINTCHR$141;"dust"
PRINTCHR$141;"dust"
PRINTCHR$147;",,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,";
PRINTCHR$131;"https://ikeserver.de/Dust"
PRINT
PRINTTAB(0,5);:db=22
ENDPROC
DEF PROCx
IF i THEN ib$=":0.$.OZMOO2P":ENDPROC
PROCob
IF PAGE>pb THEN PROCjb("Sorry, you need PAGE<=&"+STR$~pb+"; it is &"+STR$~PAGE+".")
IF qb THEN rb=pb-PAGE:sb=PAGE:?&408=sb DIV 256 ELSE rb=0
tb=tb-&4000*?&904
ub=&400-rb
IF l AND tb>0 THEN PROCvb(tb+FNwb(ub,0),"sideways RAM")
xb=tb+ub
IF xb>0 THEN PROCvb(xb,"main or sideways RAM")
ENDPROC
DEF PROCob
IF l THEN ib$=":0.$.OZMOOE":pb=7424:qb=TRUE:tb=7680:ENDPROC
IF h THEN ib$=":0.$.OZMOOSH":pb=&3100:qb=TRUE:tb=0:ENDPROC
ib$=":0.$.OZMOOB":pb=6400:qb=FALSE:tb=-5120
ENDPROC
DEF PROCy
DIM yb(8),zb(8)
ac=2
bc=1
DIM cc$(ac,bc),dc(ac)
cc$(0,0)="0) 80x32"
cc$(0,1)="3) 80x25"
cc$(1,0)="4) 40x32"
cc$(1,1)="6) 40x25"
cc$(2,0)="7) 40x25   "
cc$(2,1)="   teletext"
IF l THEN ac=1:ec$="0346" ELSE ec$="03467"
FOR fc=bc TO 0 STEP -1:FOR gc=0 TO ac:hc=VALLEFT$(cc$(gc,fc),1):yb(hc)=gc:zb(hc)=fc:NEXT:NEXT
PRINT CHR$p;"Screen mode:";CHR$o;CHR$s;"(hit ";:ic$="":FOR jc=1 TO LEN(ec$):PRINT ic$;MID$(ec$,jc,1);:ic$="/":NEXT:PRINT " to change)"
kc=VPOS
IF ac=2 THEN lc=0 ELSE lc=5
FOR fc=0 TO bc:PRINTTAB(0,kc+fc);CHR$o;:FOR gc=0 TO ac:dc(gc)=POS:PRINT SPC2;cc$(gc,fc);SPC(2+lc);:NEXT:NEXT
z=kc+bc+2
hc$="7":IF INSTR(ec$,hc$)=0 THEN hc$=RIGHT$(ec$,1)
gc=yb(VALhc$):fc=zb(VALhc$):PROCmc(gc,fc,TRUE):PROCbb
REPEAT
nc=gc:oc=fc
pc=GET
IF pc=136 AND gc>0 THEN gc=gc-1
IF pc=137 AND gc<ac THEN gc=gc+1
IF pc=138 AND fc<bc THEN fc=fc+1
IF pc=139 AND fc>0 THEN fc=fc-1
pc$=CHR$pc:IF INSTR(ec$,pc$)<>0 THEN gc=yb(VALpc$):IF NOT FNqc7(gc) THEN fc=zb(VALpc$)
IF gc<>nc OR (fc<>oc AND NOT FNqc7(gc)) THEN PROCmc(nc,oc,FALSE):PROCmc(gc,fc,TRUE)
UNTIL FNcb(pc)
ENDPROC
DEF FNcb(pc)
IF l AND pc=2 THEN ?d=(?d+1) MOD 8:VDU 19,0,?d,0;0
IF l AND pc=6 THEN ?c=(?c+1) MOD 8:VDU 19,7,?c,0;0
=pc=32 OR pc=13
DEF PROCmc(gc,fc,rc)
IF rc AND FNqc7(gc) THEN ?e=7 ELSE IF rc THEN ?e=VAL(cc$(gc,fc))
IF rc THEN PROCab
IF l THEN PROCsc(gc,fc,rc):ENDPROC
IF FNqc7(gc) THEN PROCtc(gc,0,rc):fc=1
DEF PROCtc(gc,fc,rc)
IF gc<2 THEN PRINTTAB(dc(gc)+3+LENcc$(gc,fc),kc+fc);CHR$o;CHR$156;
PRINTTAB(dc(gc)-1,kc+fc);
IF rc THEN PRINT CHR$r;CHR$157;CHR$q ELSE PRINT "  ";CHR$o
ENDPROC
DEF PROCsc(gc,fc,rc)
PRINTTAB(dc(gc),kc+fc);
IF rc THEN COLOUR 135:COLOUR 0 ELSE COLOUR 128:COLOUR 7
PRINT SPC(2);cc$(gc,fc);SPC(2);
COLOUR 128:COLOUR 7
ENDPROC
DEF PROCnb(uc,mb$)
vc$=CHR$uc+STRING$(POS," ")
jc=1
VDU uc
REPEAT
bb=INSTR(mb$," ",jc+1)
IF bb=0 THEN wc$=MID$(mb$,jc) ELSE wc$=MID$(mb$,jc,bb-jc)
xc=POS+LENwc$
IF xc<40 THEN PRINT wc$;" "; ELSE IF xc=40 THEN PRINT wc$; ELSE PRINT'vc$;wc$;" ";
IF POS=0 AND bb<>0 THEN PRINT vc$;
jc=bb+1
UNTIL bb=0
IF POS<>0 THEN PRINT
ENDPROC
DEF PROCj
!&70=f%:?f%=0
P%=f%+1
[OPT 0
LDY #0:TYA
.yc
STA &300,Y
DEY:BNE yc
LDA #&80:STA &FEF0
LDA #1:STA &371:STA (&70),Y
STY &371:LDA (&70),Y
RTS
]
zc=(USR(f%+1) AND &FF)=0
IF zc THEN u$="256K" ELSE u$="64K"
?&40E=zc
ENDPROC
DEF PROCg
*/FINDSWR
ad=FNbd(&904):v$=""
IF FNbd(&903)>2 THEN v$="("+STR$(ad*16)+"K unsupported sideways RAM)"
IF ad=0 THEN ENDPROC
v$=STR$(ad*16)+"K sideways RAM (bank":IF ad>1 THEN v$=v$+"s"
v$=v$+" &":FOR jc=0 TO ad-1:v$=v$+STR$~FNbd(&905+jc):NEXT:v$=v$+")"
ENDPROC
DEF PROCcd(dd$):PROCjb("Sorry, this game won't run on "+dd$+".")
DEF PROCvb(ed,fd$):PROCjb("Sorry, you need at least "+STR$(ed/1024)+"K more "+fd$+".")
DEF PROCab
gd7hd=NOT (h OR i OR l)
id=id
IF id=0 THEN PRINTTAB(0,z);CHR$p;"In-game controls:" ELSE PRINTTAB(0,z+1);
PRINT CHR$o;"  SHIFT:  show next page of text"
IF ?e=7 THEN PRINT CHR$o;"  CTRL-F: change status line colour"
IF ?e<>7 THEN PRINT CHR$o;"  CTRL-F: change foreground colour "
IF ?e<>7 THEN PRINT CHR$o;"  CTRL-B: change background colour "
IF NOT gd7hd THEN PRINT CHR$o;"  CTRL-S: change scrolling mode    "
IF VPOS<id THEN PRINT SPC(40*(id-VPOS));
id=VPOS
ENDPROC
DEF PROCbb
PRINTTAB(0,db);CHR$o;"Press SPACE/RETURN to start the game...";
ENDPROC
DEF FNqc7(gc)=LEFT$(cc$(gc,0),1)="7"
DEF PROCgb($f%):X%=f%:Y%=X%DIV256:CALL&FFF7:ENDPROC
DEF FNbd(jd):!f%=&FFFF0000 OR jd:A%=5:X%=f%:Y%=f% DIV 256:CALL &FFF1:=f%?4
DEF FNeb:A%=0:Y%=0:=USR&FFDA AND &FF
DEF FNfb
DIM kd% 256
fb$=""
REPEAT
f%!1=kd%
A%=6:X%=f%:Y%=f% DIV 256:CALL &FFD1
ld=kd%+1+?kd%
ld?(1+?ld)=13
ld$=FNmd($(ld+1))
fb$=ld$+"."+fb$
IF ld$<>"$" AND ld$<>"&" THEN *DIR ^
UNTIL ld$="$" OR ld$="&"
fb$=LEFT$(fb$,LEN(fb$)-1)
?ld=13
nd$=FNmd($(kd%+1))
IF nd$<>"" THEN fb$=":"+nd$+"."+fb$
PROCgb("DIR "+fb$)
=fb$
DEF FNmd(od$)
od$=od$+" "
REPEAT:od$=LEFT$(od$,LEN(od$)-1):UNTIL RIGHT$(od$,1)<>" "
=od$
DEF FNwb(pd,qd):IF pd<qd THEN =qd ELSE =pd
