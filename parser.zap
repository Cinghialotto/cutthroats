

	.FUNCT	PARSER,PTR=P-LEXSTART,WORD,VAL=0,VERB=0,LEN,DIR=0,NW=0,LW=0,NUM,SCNT,CNT=-1
?PRG1:	IGRTR?	'CNT,P-ITBLLEN \?ELS5
	JUMP	?REP2
?ELS5:	PUT	P-ITBL,CNT,0
	JUMP	?PRG1
?REP2:	SET	'P-NAM,FALSE-VALUE
	SET	'P-ADJ,FALSE-VALUE
	SET	'P-ADVERB,FALSE-VALUE
	SET	'P-MERGED,FALSE-VALUE
	SET	'P-NONE,FALSE-VALUE
	PUT	P-PRSO,P-MATCHLEN,0
	PUT	P-PRSI,P-MATCHLEN,0
	PUT	P-BUTS,P-MATCHLEN,0
	ZERO?	QUOTE-FLAG \?CND8
	EQUAL?	WINNER,PLAYER /?CND8
	SET	'WINNER,PLAYER
	LOC	WINNER
	FSET?	STACK,VEHBIT /?CND8
	LOC	WINNER >HERE
?CND8:	ZERO?	P-CONT /?ELS18
	SET	'PTR,P-CONT
	SET	'P-CONT,FALSE-VALUE
	EQUAL?	L-PRSA,V?TELL /?CND16
	CRLF	
	JUMP	?CND16
?ELS18:	SET	'WINNER,PLAYER
	SET	'QUOTE-FLAG,FALSE-VALUE
	LOC	WINNER
	FSET?	STACK,VEHBIT /?CND25
	LOC	WINNER >HERE
?CND25:	PUTB	P-LEXV,0,59
	ZERO?	SUPER-BRIEF \?CND28
	CRLF	
?CND28:	PRINTI	">"
	READ	P-INBUF,P-LEXV
?CND16:	GETB	P-LEXV,P-LEXWORDS >P-LEN
	ZERO?	P-LEN \?ELS35
	PRINTI	"What?"
	CRLF	
	RFALSE	
?ELS35:	GET	P-LEXV,PTR >WORD
	EQUAL?	WORD,W?WHY,W?HOW,W?WHEN /?THN40
	EQUAL?	WORD,W?IS,W?DID,W?ARE \?CND33
?THN40:	PRINTI	"Sorry, but this program can't handle questions like that. You should stick to questions like ""WHAT IS ..."" and ""WHERE IS ...."" Maybe you'd like to reread the manual."
	CRLF	
	RFALSE	
?CND33:	SET	'LEN,P-LEN
	SET	'P-DIR,FALSE-VALUE
	SET	'P-NCN,0
	SET	'P-GETFLAGS,0
	PUT	P-ITBL,P-VERBN,0
?PRG44:	DLESS?	'P-LEN,0 \?ELS48
	SET	'QUOTE-FLAG,FALSE-VALUE
	JUMP	?REP45
?ELS48:	GET	P-LEXV,PTR >WORD
	ZERO?	WORD \?THN51
	CALL	NUMBER?,PTR >WORD
	ZERO?	WORD /?ELS50
?THN51:	EQUAL?	WORD,W?TO \?ELS55
	EQUAL?	VERB,ACT?TELL,ACT?ASK \?ELS55
	SET	'WORD,W?QUOTE
	JUMP	?CND53
?ELS55:	EQUAL?	WORD,W?THEN \?CND53
	ZERO?	VERB \?CND53
	PUT	P-ITBL,P-VERB,ACT?TELL
	PUT	P-ITBL,P-VERBN,0
	SET	'WORD,W?QUOTE
?CND53:	EQUAL?	WORD,W?PERIOD \?ELS64
	EQUAL?	LW,W?MR \?ELS64
	SET	'LW,0
	JUMP	?CND46
?ELS64:	EQUAL?	WORD,W?THEN,W?PERIOD,W?QUOTE \?ELS68
	EQUAL?	WORD,W?QUOTE \?CND69
	ZERO?	QUOTE-FLAG /?ELS74
	SET	'QUOTE-FLAG,FALSE-VALUE
	JUMP	?CND69
?ELS74:	SET	'QUOTE-FLAG,TRUE-VALUE
?CND69:	ZERO?	P-LEN /?THN78
	ADD	PTR,P-LEXELEN >P-CONT
?THN78:	PUTB	P-LEXV,P-LEXWORDS,P-LEN
	JUMP	?REP45
?ELS68:	CALL	WT?,WORD,PS?DIRECTION,P1?DIRECTION >VAL
	ZERO?	VAL /?ELS81
	EQUAL?	VERB,FALSE-VALUE,ACT?WALK \?ELS81
	EQUAL?	LEN,1 /?THN84
	EQUAL?	LEN,2 \?ELS87
	EQUAL?	VERB,ACT?WALK /?THN84
?ELS87:	ADD	PTR,P-LEXELEN
	GET	P-LEXV,STACK >NW
	EQUAL?	NW,W?THEN,W?QUOTE \?ELS89
	GRTR?	LEN,2 /?THN84
?ELS89:	EQUAL?	NW,W?PERIOD \?ELS91
	GRTR?	LEN,1 /?THN84
?ELS91:	ZERO?	QUOTE-FLAG /?ELS93
	EQUAL?	LEN,2 \?ELS93
	EQUAL?	NW,W?QUOTE /?THN84
?ELS93:	GRTR?	LEN,2 \?ELS81
	EQUAL?	NW,W?COMMA,W?AND \?ELS81
?THN84:	SET	'DIR,VAL
	EQUAL?	NW,W?COMMA,W?AND \?CND96
	ADD	PTR,P-LEXELEN
	PUT	P-LEXV,STACK,W?THEN
?CND96:	GRTR?	LEN,2 /?CND46
	SET	'QUOTE-FLAG,FALSE-VALUE
	JUMP	?REP45
?ELS81:	CALL	WT?,WORD,PS?VERB,P1?VERB >VAL
	ZERO?	VAL /?ELS103
	ZERO?	VERB \?ELS103
	SET	'VERB,VAL
	PUT	P-ITBL,P-VERB,VAL
	PUT	P-ITBL,P-VERBN,P-VTBL
	PUT	P-VTBL,0,WORD
	MUL	PTR,2
	ADD	STACK,2 >NUM
	GETB	P-LEXV,NUM
	PUTB	P-VTBL,2,STACK
	ADD	NUM,1
	GETB	P-LEXV,STACK
	PUTB	P-VTBL,3,STACK
	JUMP	?CND46
?ELS103:	CALL	WT?,WORD,PS?PREPOSITION,0 >VAL
	ZERO?	VAL \?THN110
	EQUAL?	WORD,W?ALL,W?ONE,W?A /?THN114
	CALL	WT?,WORD,PS?ADJECTIVE
	ZERO?	STACK \?THN114
	CALL	WT?,WORD,PS?OBJECT
	ZERO?	STACK /?ELS109
?THN114:	SET	'VAL,0
?THN110:	GRTR?	P-LEN,0 \?ELS118
	ADD	PTR,P-LEXELEN
	GET	P-LEXV,STACK
	EQUAL?	STACK,W?OF \?ELS118
	EQUAL?	VERB,ACT?MAKE /?ELS118
	ZERO?	VAL \?ELS118
	EQUAL?	WORD,W?ALL,W?ONE,W?A /?ELS118
	JUMP	?CND46
?ELS118:	ZERO?	VAL /?ELS122
	ZERO?	P-LEN /?THN125
	ADD	PTR,2
	GET	P-LEXV,STACK
	EQUAL?	STACK,W?THEN,W?PERIOD \?ELS122
?THN125:	LESS?	P-NCN,2 \?CND46
	PUT	P-ITBL,P-PREP1,VAL
	PUT	P-ITBL,P-PREP1N,WORD
	JUMP	?CND46
?ELS122:	EQUAL?	P-NCN,2 \?ELS131
	PRINTI	"I found more than two nouns in that sentence!"
	CRLF	
	RFALSE	
?ELS131:	INC	'P-NCN
	CALL	CLAUSE,PTR,VAL,WORD >PTR
	ZERO?	PTR /FALSE
	LESS?	PTR,0 \?CND46
	SET	'QUOTE-FLAG,FALSE-VALUE
	JUMP	?REP45
?ELS109:	EQUAL?	WORD,W?QUIETLY /?THN143
	EQUAL?	WORD,W?SLOWLY,W?QUICKLY,W?BRIEFLY \?ELS142
?THN143:	SET	'P-ADVERB,WORD
	JUMP	?CND46
?ELS142:	CALL	WT?,WORD,PS?BUZZ-WORD
	ZERO?	STACK /?ELS146
	JUMP	?CND46
?ELS146:	CALL	CANT-USE,PTR
	RFALSE	
?ELS50:	CALL	UNKNOWN-WORD,PTR
	RFALSE	
?CND46:	SET	'LW,WORD
	ADD	PTR,P-LEXELEN >PTR
	JUMP	?PRG44
?REP45:	ZERO?	DIR /?CND151
	SET	'PRSA,V?WALK
	SET	'PRSO,DIR
	SET	'P-WALK-DIR,DIR
	RETURN	TRUE-VALUE
?CND151:	ZERO?	P-OFLAG /?CND155
	CALL	ORPHAN-MERGE
?CND155:	GET	P-ITBL,P-VERB
	ZERO?	STACK \?CND159
	PUT	P-ITBL,P-VERB,ACT?$CALL
?CND159:	CALL	SYNTAX-CHECK
	ZERO?	STACK /FALSE
	CALL	SNARF-OBJECTS
	ZERO?	STACK /FALSE
	CALL	MANY-CHECK
	ZERO?	STACK /FALSE
	CALL	TAKE-CHECK
	ZERO?	STACK /FALSE
	RTRUE


	.FUNCT	WT?,PTR,BIT,B1=5,OFFSET=P-P1OFF,TYP
	GETB	PTR,P-PSOFF >TYP
	BTST	TYP,BIT \FALSE
	GRTR?	B1,4 /TRUE
	BAND	TYP,P-P1BITS >TYP
	EQUAL?	TYP,B1 /?CND13
	INC	'OFFSET
?CND13:	GETB	PTR,OFFSET
	RSTACK	


	.FUNCT	CLAUSE,PTR,VAL,WORD,OFF,NUM,ANDFLG=0,FIRST??=1,NW,LW=0,?TMP1
	SUB	P-NCN,1
	MUL	STACK,2 >OFF
	ZERO?	VAL /?ELS3
	ADD	P-PREP1,OFF >NUM
	PUT	P-ITBL,NUM,VAL
	ADD	NUM,1
	PUT	P-ITBL,STACK,WORD
	ADD	PTR,P-LEXELEN >PTR
	JUMP	?CND1
?ELS3:	INC	'P-LEN
?CND1:	ZERO?	P-LEN \?CND6
	DEC	'P-NCN
	RETURN	-1
?CND6:	ADD	P-NC1,OFF >NUM
	MUL	PTR,2
	ADD	P-LEXV,STACK
	PUT	P-ITBL,NUM,STACK
	GET	P-LEXV,PTR
	EQUAL?	STACK,W?THE,W?A,W?AN \?CND9
	GET	P-ITBL,NUM
	ADD	STACK,4
	PUT	P-ITBL,NUM,STACK
?CND9:	
?PRG12:	DLESS?	'P-LEN,0 \?CND14
	ADD	NUM,1 >?TMP1
	MUL	PTR,2
	ADD	P-LEXV,STACK
	PUT	P-ITBL,?TMP1,STACK
	RETURN	-1
?CND14:	GET	P-LEXV,PTR >WORD
	ZERO?	WORD \?THN20
	CALL	NUMBER?,PTR >WORD
	ZERO?	WORD /?ELS19
?THN20:	ZERO?	P-LEN \?ELS24
	SET	'NW,0
	JUMP	?CND22
?ELS24:	ADD	PTR,P-LEXELEN
	GET	P-LEXV,STACK >NW
?CND22:	EQUAL?	WORD,W?OF \?CND27
	GET	P-ITBL,P-VERB
	EQUAL?	STACK,ACT?MAKE \?CND27
	PUT	P-LEXV,PTR,W?WITH
	SET	'WORD,W?WITH
?CND27:	EQUAL?	WORD,W?PERIOD \?ELS34
	EQUAL?	LW,W?MR \?ELS34
	SET	'LW,0
	JUMP	?CND17
?ELS34:	EQUAL?	WORD,W?AND,W?COMMA \?ELS38
	SET	'ANDFLG,TRUE-VALUE
	JUMP	?CND17
?ELS38:	EQUAL?	WORD,W?ALL,W?ONE \?ELS40
	EQUAL?	NW,W?OF \?CND17
	DEC	'P-LEN
	ADD	PTR,P-LEXELEN >PTR
	JUMP	?CND17
?ELS40:	EQUAL?	WORD,W?THEN,W?PERIOD /?THN46
	CALL	WT?,WORD,PS?PREPOSITION
	ZERO?	STACK /?ELS45
	ZERO?	FIRST?? \?ELS45
?THN46:	INC	'P-LEN
	ADD	NUM,1 >?TMP1
	MUL	PTR,2
	ADD	P-LEXV,STACK
	PUT	P-ITBL,?TMP1,STACK
	SUB	PTR,P-LEXELEN
	RETURN	STACK
?ELS45:	ZERO?	ANDFLG /?ELS51
	GET	P-ITBL,P-VERBN
	ZERO?	STACK /?THN54
	CALL	WT?,WORD,PS?DIRECTION
	ZERO?	STACK \?THN54
	CALL	WT?,WORD,PS?VERB
	ZERO?	STACK /?ELS51
?THN54:	SUB	PTR,4 >PTR
	ADD	PTR,2
	PUT	P-LEXV,STACK,W?THEN
	ADD	P-LEN,2 >P-LEN
	JUMP	?CND17
?ELS51:	CALL	WT?,WORD,PS?OBJECT
	ZERO?	STACK /?ELS57
	GRTR?	P-LEN,0 \?ELS60
	EQUAL?	NW,W?OF \?ELS60
	EQUAL?	WORD,W?ALL,W?ONE /?ELS60
	JUMP	?CND17
?ELS60:	CALL	WT?,WORD,PS?ADJECTIVE,P1?ADJECTIVE
	ZERO?	STACK /?ELS64
	ZERO?	NW /?ELS64
	CALL	WT?,NW,PS?OBJECT
	ZERO?	STACK /?ELS64
	JUMP	?CND17
?ELS64:	ZERO?	ANDFLG \?ELS68
	EQUAL?	NW,W?BUT,W?EXCEPT /?ELS68
	EQUAL?	NW,W?AND,W?COMMA /?ELS68
	ADD	NUM,1 >?TMP1
	ADD	PTR,2
	MUL	STACK,2
	ADD	P-LEXV,STACK
	PUT	P-ITBL,?TMP1,STACK
	RETURN	PTR
?ELS68:	SET	'ANDFLG,FALSE-VALUE
	JUMP	?CND17
?ELS57:	CALL	WT?,WORD,PS?ADJECTIVE
	ZERO?	STACK /?ELS74
	JUMP	?CND17
?ELS74:	CALL	WT?,WORD,PS?BUZZ-WORD
	ZERO?	STACK /?ELS79
	JUMP	?CND17
?ELS79:	CALL	WT?,WORD,PS?PREPOSITION
	ZERO?	STACK /?ELS81
	JUMP	?CND17
?ELS81:	CALL	CANT-USE,PTR
	RFALSE	
?ELS19:	CALL	UNKNOWN-WORD,PTR
	RFALSE	
?CND17:	SET	'LW,WORD
	SET	'FIRST??,FALSE-VALUE
	ADD	PTR,P-LEXELEN >PTR
	JUMP	?PRG12


	.FUNCT	NUMBER?,PTR,CNT,BPTR,CHR,SUM=0,TIM=0,?TMP1
	MUL	PTR,2
	ADD	P-LEXV,STACK
	GETB	STACK,2 >CNT
	MUL	PTR,2
	ADD	P-LEXV,STACK
	GETB	STACK,3 >BPTR
	SET	'P-DOLLAR-FLAG,FALSE-VALUE
?PRG1:	DLESS?	'CNT,0 \?ELS5
	JUMP	?REP2
?ELS5:	GETB	P-INBUF,BPTR >CHR
	EQUAL?	CHR,58 \?ELS10
	SET	'TIM,SUM
	SET	'SUM,0
	JUMP	?CND8
?ELS10:	GRTR?	SUM,9999 /FALSE
	LESS?	CHR,58 \?ELS14
	GRTR?	CHR,47 \?ELS14
	MUL	SUM,10 >?TMP1
	SUB	CHR,48
	ADD	?TMP1,STACK >SUM
	JUMP	?CND8
?ELS14:	EQUAL?	CHR,36 \FALSE
	SET	'P-DOLLAR-FLAG,TRUE-VALUE
?CND8:	INC	'BPTR
	JUMP	?PRG1
?REP2:	PUT	P-LEXV,PTR,W?INTNUM
	GRTR?	SUM,9999 /FALSE
	ZERO?	TIM /?CND21
	SET	'SET-HR,TIM
	SET	'SET-MIN,SUM
	GRTR?	TIM,23 /FALSE
	MUL	TIM,60
	ADD	SUM,STACK >SUM
?CND21:	ZERO?	P-DOLLAR-FLAG /?ELS32
	GRTR?	SUM,0 \?ELS32
	SET	'P-AMOUNT,SUM
	FSET	INTNUM,VOWELBIT
	PUTP	INTNUM,P?SDESC,STR?50
	RETURN	W?INTNUM
?ELS32:	SET	'P-NUMBER,SUM
	SET	'P-DOLLAR-FLAG,FALSE-VALUE
	FCLEAR	INTNUM,VOWELBIT
	PUTP	INTNUM,P?SDESC,STR?1
	RETURN	W?INTNUM


	.FUNCT	ORPHAN-MERGE,CNT=-1,TEMP,VERB,BEG,END,ADJ=0,WRD,?TMP1
	SET	'P-OFLAG,FALSE-VALUE
	GET	P-ITBL,P-VERBN
	GET	STACK,0
	CALL	WT?,STACK,PS?ADJECTIVE,P1?ADJECTIVE
	ZERO?	STACK /?CND1
	SET	'ADJ,TRUE-VALUE
?CND1:	GET	P-ITBL,P-VERB >VERB
	ZERO?	VERB /?ELS6
	ZERO?	ADJ \?ELS6
	GET	P-OTBL,P-VERB
	EQUAL?	VERB,STACK \FALSE
?ELS6:	EQUAL?	P-NCN,2 /FALSE
	GET	P-OTBL,P-NC1
	EQUAL?	STACK,1 \?ELS12
	GET	P-ITBL,P-PREP1 >TEMP
	GET	P-OTBL,P-PREP1
	EQUAL?	TEMP,STACK /?THN16
	ZERO?	TEMP \FALSE
?THN16:	ZERO?	ADJ /?ELS20
	ADD	P-LEXV,2
	PUT	P-OTBL,P-NC1,STACK
	ADD	P-LEXV,6
	PUT	P-OTBL,P-NC1L,STACK
	JUMP	?CND4
?ELS20:	GET	P-ITBL,P-NC1
	PUT	P-OTBL,P-NC1,STACK
	GET	P-ITBL,P-NC1L
	PUT	P-OTBL,P-NC1L,STACK
	JUMP	?CND4
?ELS12:	GET	P-OTBL,P-NC2
	EQUAL?	STACK,1 \?ELS27
	GET	P-ITBL,P-PREP1 >TEMP
	GET	P-OTBL,P-PREP2
	EQUAL?	TEMP,STACK /?THN31
	ZERO?	TEMP \FALSE
?THN31:	ZERO?	ADJ /?CND33
	ADD	P-LEXV,2
	PUT	P-ITBL,P-NC1,STACK
	ADD	P-LEXV,6
	PUT	P-ITBL,P-NC1L,STACK
?CND33:	GET	P-ITBL,P-NC1
	PUT	P-OTBL,P-NC2,STACK
	GET	P-ITBL,P-NC1L
	PUT	P-OTBL,P-NC2L,STACK
	SET	'P-NCN,2
	JUMP	?CND4
?ELS27:	ZERO?	P-ACLAUSE /?CND4
	EQUAL?	P-NCN,1 /?ELS44
	ZERO?	ADJ \?ELS44
	SET	'P-ACLAUSE,FALSE-VALUE
	RFALSE	
?ELS44:	GET	P-ITBL,P-NC1 >BEG
	ZERO?	ADJ /?CND49
	ADD	P-LEXV,2 >BEG
	SET	'ADJ,FALSE-VALUE
?CND49:	GET	P-ITBL,P-NC1L >END
?PRG53:	GET	BEG,0 >WRD
	EQUAL?	BEG,END \?ELS57
	ZERO?	ADJ /?ELS60
	CALL	ACLAUSE-WIN,ADJ
	JUMP	?CND42
?ELS60:	SET	'P-ACLAUSE,FALSE-VALUE
	RFALSE	
?ELS57:	ZERO?	ADJ \?ELS65
	GETB	WRD,P-PSOFF
	BTST	STACK,PS?ADJECTIVE /?THN68
	EQUAL?	WRD,W?ALL,W?ONE \?ELS65
?THN68:	SET	'ADJ,WRD
	JUMP	?CND55
?ELS65:	GETB	WRD,P-PSOFF
	BTST	STACK,PS?OBJECT /?THN72
	EQUAL?	WRD,W?ONE \?CND55
?THN72:	EQUAL?	WRD,P-ANAM,W?ONE \FALSE
	CALL	ACLAUSE-WIN,ADJ
	JUMP	?CND42
?CND55:	ADD	BEG,P-WORDLEN >BEG
	ZERO?	END \?PRG53
	SET	'END,BEG
	SET	'P-NCN,1
	SUB	BEG,4
	PUT	P-ITBL,P-NC1,STACK
	PUT	P-ITBL,P-NC1L,BEG
	JUMP	?PRG53
?CND42:	
?CND4:	
?PRG82:	IGRTR?	'CNT,P-ITBLLEN \?ELS86
	SET	'P-MERGED,TRUE-VALUE
	RTRUE	
?ELS86:	GET	P-OTBL,CNT
	PUT	P-ITBL,CNT,STACK
	JUMP	?PRG82


	.FUNCT	ACLAUSE-WIN,ADJ
	GET	P-OTBL,P-VERB
	PUT	P-ITBL,P-VERB,STACK
	SET	'P-CCSRC,P-OTBL
	ADD	P-ACLAUSE,1
	CALL	CLAUSE-COPY,P-ACLAUSE,STACK,ADJ
	GET	P-OTBL,P-NC2
	ZERO?	STACK /?ELS2
	SET	'P-NCN,2
?ELS2:	SET	'P-ACLAUSE,FALSE-VALUE
	RTRUE	


	.FUNCT	WORD-PRINT,CNT,BUF
?PRG1:	DLESS?	'CNT,0 /TRUE
	GETB	P-INBUF,BUF
	PRINTC	STACK
	INC	'BUF
	JUMP	?PRG1


	.FUNCT	UNKNOWN-WORD,PTR,BUF,MSG,?TMP1
	PRINTI	"I don't know the word """
	MUL	PTR,2 >BUF
	ADD	P-LEXV,BUF
	GETB	STACK,2 >?TMP1
	ADD	P-LEXV,BUF
	GETB	STACK,3
	CALL	WORD-PRINT,?TMP1,STACK
	PRINTI	"""."
	CRLF	
	SET	'QUOTE-FLAG,FALSE-VALUE
	SET	'P-OFLAG,FALSE-VALUE
	RETURN	P-OFLAG


	.FUNCT	CANT-USE,PTR,BUF,?TMP1
	PRINTI	"Sorry, but you can't use the word """
	MUL	PTR,2 >BUF
	ADD	P-LEXV,BUF
	GETB	STACK,2 >?TMP1
	ADD	P-LEXV,BUF
	GETB	STACK,3
	CALL	WORD-PRINT,?TMP1,STACK
	PRINTI	""" in that sense."
	CRLF	
	SET	'QUOTE-FLAG,FALSE-VALUE
	SET	'P-OFLAG,FALSE-VALUE
	RETURN	P-OFLAG


	.FUNCT	SYNTAX-CHECK,SYN,LEN,NUM,OBJ,DRIVE1=0,DRIVE2=0,PREP,VERB,?TMP2,?TMP1
	GET	P-ITBL,P-VERB >VERB
	ZERO?	VERB \?CND1
	CALL	TELL-COULDNT-FIND,STR?51
	RFALSE	
?CND1:	SUB	255,VERB
	GET	VERBS,STACK >SYN
	GETB	SYN,0 >LEN
	ADD	1,SYN >SYN
?PRG4:	GETB	SYN,P-SBITS
	BAND	STACK,P-SONUMS >NUM
	GRTR?	P-NCN,NUM \?ELS8
	JUMP	?CND6
?ELS8:	LESS?	NUM,1 /?ELS10
	ZERO?	P-NCN \?ELS10
	GET	P-ITBL,P-PREP1 >PREP
	ZERO?	PREP /?THN13
	GETB	SYN,P-SPREP1
	EQUAL?	PREP,STACK \?ELS10
?THN13:	SET	'DRIVE1,SYN
	JUMP	?CND6
?ELS10:	GETB	SYN,P-SPREP1 >?TMP1
	GET	P-ITBL,P-PREP1
	EQUAL?	?TMP1,STACK \?CND6
	EQUAL?	NUM,2 \?ELS19
	EQUAL?	P-NCN,1 \?ELS19
	SET	'DRIVE2,SYN
	JUMP	?CND6
?ELS19:	GETB	SYN,P-SPREP2 >?TMP1
	GET	P-ITBL,P-PREP2
	EQUAL?	?TMP1,STACK \?CND6
	CALL	SYNTAX-FOUND,SYN
	RTRUE	
?CND6:	DLESS?	'LEN,1 \?ELS26
	ZERO?	DRIVE1 \?REP5
	ZERO?	DRIVE2 /?ELS29
	JUMP	?REP5
?ELS29:	PRINTI	"I don't understand that sentence."
	CRLF	
	RFALSE	
?ELS26:	ADD	SYN,P-SYNLEN >SYN
	JUMP	?PRG4
?REP5:	ZERO?	DRIVE1 /?ELS42
	GETB	DRIVE1,P-SFWIM1 >?TMP2
	GETB	DRIVE1,P-SLOC1 >?TMP1
	GETB	DRIVE1,P-SPREP1
	CALL	GWIM,?TMP2,?TMP1,STACK >OBJ
	ZERO?	OBJ /?ELS42
	PUT	P-PRSO,P-MATCHLEN,1
	PUT	P-PRSO,1,OBJ
	CALL	SYNTAX-FOUND,DRIVE1
	RSTACK	
?ELS42:	ZERO?	DRIVE2 /?ELS46
	GETB	DRIVE2,P-SFWIM2 >?TMP2
	GETB	DRIVE2,P-SLOC2 >?TMP1
	GETB	DRIVE2,P-SPREP2
	CALL	GWIM,?TMP2,?TMP1,STACK >OBJ
	ZERO?	OBJ /?ELS46
	PUT	P-PRSI,P-MATCHLEN,1
	PUT	P-PRSI,1,OBJ
	CALL	SYNTAX-FOUND,DRIVE2
	RSTACK	
?ELS46:	EQUAL?	VERB,ACT?FIND \?ELS50
	EQUAL?	WINNER,PLAYER /?ELS53
	PRINTI	"You'll have to ask a more specific question."
	CRLF	
	RFALSE	
?ELS53:	PRINTI	"Sorry, but I can't answer that question."
	CRLF	
	RFALSE	
?ELS50:	EQUAL?	WINNER,PLAYER \?ELS64
	CALL	ORPHAN,DRIVE1,DRIVE2
	EQUAL?	VERB,ACT?WALK \?ELS67
	PRINTI	"Where"
	JUMP	?CND65
?ELS67:	PRINTI	"What"
?CND65:	PRINTI	" do you want to "
	JUMP	?CND62
?ELS64:	CALL	REQUEST-INCOMPLETE
	PRINTI	"what you want "
	CALL	THE?,WINNER
	CALL	DPRINT,WINNER
	PRINTI	" to "
?CND62:	CALL	VERB-PRINT
	ZERO?	DRIVE2 /?CND82
	CALL	CLAUSE-PRINT,P-NC1,P-NC1L
?CND82:	ZERO?	DRIVE1 /?ELS90
	GETB	DRIVE1,P-SPREP1
	JUMP	?CND86
?ELS90:	GETB	DRIVE2,P-SPREP2
?CND86:	CALL	PREP-PRINT,STACK
	EQUAL?	WINNER,PLAYER \?ELS96
	SET	'P-OFLAG,TRUE-VALUE
	PRINTI	"?"
	CRLF	
	RFALSE	
?ELS96:	SET	'P-OFLAG,FALSE-VALUE
	PRINTI	"."
	CRLF	
	RFALSE	


	.FUNCT	REQUEST-INCOMPLETE
	PRINTI	"Your request was incomplete. Next time, say "
	RTRUE	


	.FUNCT	VERB-PRINT,TMP,?TMP1
	GET	P-ITBL,P-VERBN >TMP
	ZERO?	TMP \?ELS5
	PRINTI	"say"
	RTRUE	
?ELS5:	GETB	P-VTBL,2
	ZERO?	STACK \?ELS9
	GET	TMP,0
	PRINTB	STACK
	RTRUE	
?ELS9:	GETB	TMP,2 >?TMP1
	GETB	TMP,3
	CALL	WORD-PRINT,?TMP1,STACK
	PUTB	P-VTBL,2,0
	RTRUE	


	.FUNCT	ORPHAN,D1,D2,CNT=-1
	PUT	P-OCLAUSE,P-MATCHLEN,0
	SET	'P-CCSRC,P-ITBL
?PRG1:	IGRTR?	'CNT,P-ITBLLEN \?ELS5
	JUMP	?REP2
?ELS5:	GET	P-ITBL,CNT
	PUT	P-OTBL,CNT,STACK
	JUMP	?PRG1
?REP2:	EQUAL?	P-NCN,2 \?CND8
	CALL	CLAUSE-COPY,P-NC2,P-NC2L
?CND8:	LESS?	P-NCN,1 /?CND11
	CALL	CLAUSE-COPY,P-NC1,P-NC1L
?CND11:	ZERO?	D1 /?ELS18
	GETB	D1,P-SPREP1
	PUT	P-OTBL,P-PREP1,STACK
	PUT	P-OTBL,P-NC1,1
	RTRUE	
?ELS18:	ZERO?	D2 /FALSE
	GETB	D2,P-SPREP2
	PUT	P-OTBL,P-PREP2,STACK
	PUT	P-OTBL,P-NC2,1
	RTRUE	


	.FUNCT	CLAUSE-PRINT,BPTR,EPTR,THE?=1,?TMP1
	GET	P-ITBL,BPTR >?TMP1
	GET	P-ITBL,EPTR
	CALL	BUFFER-PRINT,?TMP1,STACK,THE?
	RSTACK	


	.FUNCT	BUFFER-PRINT,BEG,END,CP,NOSP=0,WRD,FIRST??=1,PN=0,?TMP1
?PRG1:	EQUAL?	BEG,END /TRUE
	ZERO?	NOSP /?ELS10
	SET	'NOSP,FALSE-VALUE
	JUMP	?CND8
?ELS10:	PRINTI	" "
?CND8:	GET	BEG,0 >WRD
	EQUAL?	WRD,W?PERIOD \?ELS18
	SET	'NOSP,TRUE-VALUE
	JUMP	?CND3
?ELS18:	EQUAL?	WRD,W?MR \?ELS20
	PRINTI	"Mr."
	SET	'PN,TRUE-VALUE
	JUMP	?CND3
?ELS20:	EQUAL?	WRD,W?MCGINTY \?ELS24
	PRINTI	"McGinty"
	SET	'PN,TRUE-VALUE
	JUMP	?CND3
?ELS24:	EQUAL?	WRD,W?ME \?ELS28
	CALL	DPRINT,GLOBAL-SELF
	SET	'PN,TRUE-VALUE
	JUMP	?CND3
?ELS28:	EQUAL?	WRD,W?WEASEL,W?PETE,W?JOHN /?THN33
	EQUAL?	WRD,W?JOHNNY,W?RED,W?RAT /?THN33
	EQUAL?	WRD,W?MARY,W?MARGAR,W?FRANK /?THN33
	EQUAL?	WRD,W?WEBSTE,W?HEVLIN \?ELS32
?THN33:	CALL	CAPITALIZE,BEG
	SET	'PN,TRUE-VALUE
	JUMP	?CND3
?ELS32:	ZERO?	FIRST?? /?CND37
	ZERO?	PN \?CND37
	ZERO?	CP /?CND37
	PRINTI	"the "
?CND37:	ZERO?	P-OFLAG \?THN47
	ZERO?	P-MERGED /?ELS46
?THN47:	EQUAL?	WRD,W?INTNUM \?ELS51
	CALL	DPRINT,INTNUM
	JUMP	?CND44
?ELS51:	PRINTB	WRD
	JUMP	?CND44
?ELS46:	EQUAL?	WRD,W?IT,W?HIM \?ELS57
	CALL	ACCESSIBLE?,P-IT-OBJECT
	ZERO?	STACK /?ELS57
	EQUAL?	P-IT-OBJECT,PSEUDO-OBJECT /?ELS57
	CALL	DPRINT,P-IT-OBJECT
	JUMP	?CND44
?ELS57:	GETB	BEG,2 >?TMP1
	GETB	BEG,3
	CALL	WORD-PRINT,?TMP1,STACK
?CND44:	SET	'FIRST??,FALSE-VALUE
?CND3:	ADD	BEG,P-WORDLEN >BEG
	JUMP	?PRG1


	.FUNCT	CAPITALIZE,PTR,?TMP1
	ZERO?	P-OFLAG \?THN6
	ZERO?	P-MERGED /?ELS5
?THN6:	GET	PTR,0
	PRINTB	STACK
	RTRUE	
?ELS5:	GETB	PTR,3
	GETB	P-INBUF,STACK
	SUB	STACK,32
	PRINTC	STACK
	GETB	PTR,2
	SUB	STACK,1 >?TMP1
	GETB	PTR,3
	ADD	STACK,1
	CALL	WORD-PRINT,?TMP1,STACK
	RSTACK	


	.FUNCT	PREP-PRINT,PREP,SP?=1,WRD
	ZERO?	PREP /FALSE
	ZERO?	SP? /?CND6
	PRINTI	" "
?CND6:	CALL	PREP-FIND,PREP >WRD
	GET	P-ITBL,P-VERBN
	GET	STACK,0
	EQUAL?	W?SIT,STACK \?ELS14
	EQUAL?	W?DOWN,WRD \?ELS14
	PRINTI	"on"
	JUMP	?CND12
?ELS14:	EQUAL?	WRD,W?AGAINST \?ELS20
	PRINTI	"against"
	JUMP	?CND12
?ELS20:	PRINTB	WRD
?CND12:	GET	P-ITBL,P-VERBN
	GET	STACK,0
	EQUAL?	W?GET,STACK \TRUE
	EQUAL?	W?OUT,WRD \TRUE
	PRINTI	" of"
	RTRUE	


	.FUNCT	CLAUSE-COPY,BPTR,EPTR,INSERT=0,BEG,END
	GET	P-CCSRC,BPTR >BEG
	GET	P-CCSRC,EPTR >END
	GET	P-OCLAUSE,P-MATCHLEN
	MUL	STACK,P-LEXELEN
	ADD	STACK,2
	ADD	P-OCLAUSE,STACK
	PUT	P-OTBL,BPTR,STACK
?PRG1:	EQUAL?	BEG,END \?ELS5
	GET	P-OCLAUSE,P-MATCHLEN
	MUL	STACK,P-LEXELEN
	ADD	STACK,2
	ADD	P-OCLAUSE,STACK
	PUT	P-OTBL,EPTR,STACK
	RTRUE	
?ELS5:	ZERO?	INSERT /?CND8
	GET	BEG,0
	EQUAL?	P-ANAM,STACK \?CND8
	CALL	CLAUSE-ADD,INSERT
?CND8:	GET	BEG,0
	CALL	CLAUSE-ADD,STACK
?CND3:	ADD	BEG,P-WORDLEN >BEG
	JUMP	?PRG1


	.FUNCT	CLAUSE-ADD,WRD,PTR
	GET	P-OCLAUSE,P-MATCHLEN
	ADD	STACK,2 >PTR
	SUB	PTR,1
	PUT	P-OCLAUSE,STACK,WRD
	PUT	P-OCLAUSE,PTR,0
	PUT	P-OCLAUSE,P-MATCHLEN,PTR
	RTRUE	


	.FUNCT	PREP-FIND,PREP,CNT=0,SIZE
	GET	PREPOSITIONS,0
	MUL	STACK,2 >SIZE
?PRG1:	IGRTR?	'CNT,SIZE /FALSE
	GET	PREPOSITIONS,CNT
	EQUAL?	STACK,PREP \?PRG1
	SUB	CNT,1
	GET	PREPOSITIONS,STACK
	RETURN	STACK


	.FUNCT	SYNTAX-FOUND,SYN
	SET	'P-SYNTAX,SYN
	GETB	SYN,P-SACTION >PRSA
	RETURN	PRSA


	.FUNCT	GWIM,GBIT,LBIT,PREP,OBJ
	EQUAL?	GBIT,RMUNGBIT \?CND1
	RETURN	ROOMS
?CND1:	SET	'P-GWIMBIT,GBIT
	SET	'P-SLOCBITS,LBIT
	PUT	P-MERGE,P-MATCHLEN,0
	CALL	GET-OBJECT,P-MERGE,FALSE-VALUE
	ZERO?	STACK /?ELS8
	SET	'P-GWIMBIT,0
	GET	P-MERGE,P-MATCHLEN
	EQUAL?	STACK,1 \FALSE
	GET	P-MERGE,1 >OBJ
	PRINTI	"("
	CALL	PREP-PRINT,PREP,FALSE-VALUE
	ZERO?	STACK /?CND16
	PRINTI	" "
	CALL	THE?,OBJ
?CND16:	CALL	DPRINT,OBJ
	PRINTI	")"
	CRLF	
	RETURN	OBJ
?ELS8:	SET	'P-GWIMBIT,0
	RFALSE	


	.FUNCT	SNARF-OBJECTS,PTR
	GET	P-ITBL,P-NC1 >PTR
	ZERO?	PTR /?CND1
	GETB	P-SYNTAX,P-SLOC1 >P-SLOCBITS
	GET	P-ITBL,P-NC1L
	CALL	SNARFEM,PTR,STACK,P-PRSO
	ZERO?	STACK /FALSE
	GET	P-BUTS,P-MATCHLEN
	ZERO?	STACK /?CND1
	CALL	BUT-MERGE,P-PRSO >P-PRSO
?CND1:	GET	P-ITBL,P-NC2 >PTR
	ZERO?	PTR /TRUE
	GETB	P-SYNTAX,P-SLOC2 >P-SLOCBITS
	GET	P-ITBL,P-NC2L
	CALL	SNARFEM,PTR,STACK,P-PRSI
	ZERO?	STACK /FALSE
	GET	P-BUTS,P-MATCHLEN
	ZERO?	STACK /TRUE
	GET	P-PRSI,P-MATCHLEN
	EQUAL?	STACK,1 \?ELS18
	CALL	BUT-MERGE,P-PRSO >P-PRSO
	RTRUE	
?ELS18:	CALL	BUT-MERGE,P-PRSI >P-PRSI
	RTRUE	


	.FUNCT	BUT-MERGE,TBL,LEN,BUTLEN,CNT=1,MATCHES=0,OBJ,NTBL
	GET	TBL,P-MATCHLEN >LEN
	PUT	P-MERGE,P-MATCHLEN,0
?PRG1:	DLESS?	'LEN,0 \?ELS5
	JUMP	?REP2
?ELS5:	GET	TBL,CNT >OBJ
	CALL	ZMEMQ,OBJ,P-BUTS
	ZERO?	STACK /?ELS7
	JUMP	?CND3
?ELS7:	ADD	MATCHES,1
	PUT	P-MERGE,STACK,OBJ
	INC	'MATCHES
?CND3:	INC	'CNT
	JUMP	?PRG1
?REP2:	PUT	P-MERGE,P-MATCHLEN,MATCHES
	SET	'NTBL,P-MERGE
	SET	'P-MERGE,TBL
	RETURN	NTBL


	.FUNCT	SNARFEM,PTR,EPTR,TBL,AND=0,BUT=0,LEN,WV,WORD,NW
	SET	'P-AND,FALSE-VALUE
	SET	'P-GETFLAGS,0
	SET	'P-CSPTR,PTR
	SET	'P-CEPTR,EPTR
	PUT	P-BUTS,P-MATCHLEN,0
	PUT	TBL,P-MATCHLEN,0
	GET	PTR,0 >WORD
?PRG1:	EQUAL?	PTR,EPTR \?ELS5
	ZERO?	BUT /?ORP9
	PUSH	BUT
	JUMP	?THN6
?ORP9:	PUSH	TBL
?THN6:	CALL	GET-OBJECT,STACK
	RETURN	STACK
?ELS5:	GET	PTR,P-LEXELEN >NW
	EQUAL?	WORD,W?ALL \?ELS14
	SET	'P-GETFLAGS,P-ALL
	EQUAL?	NW,W?OF \?CND12
	ADD	PTR,P-WORDLEN >PTR
	JUMP	?CND12
?ELS14:	EQUAL?	WORD,W?BUT,W?EXCEPT \?ELS19
	ZERO?	BUT /?ORP25
	PUSH	BUT
	JUMP	?THN22
?ORP25:	PUSH	TBL
?THN22:	CALL	GET-OBJECT,STACK
	ZERO?	STACK /FALSE
	SET	'BUT,P-BUTS
	PUT	BUT,P-MATCHLEN,0
	JUMP	?CND3
?ELS19:	EQUAL?	WORD,W?A,W?ONE \?ELS27
	ZERO?	P-ADJ \?ELS30
	SET	'P-GETFLAGS,P-ONE
	EQUAL?	NW,W?OF \?CND3
	ADD	PTR,P-WORDLEN >PTR
	JUMP	?CND3
?ELS30:	SET	'P-NAM,P-ONEOBJ
	ZERO?	BUT /?ORP41
	PUSH	BUT
	JUMP	?THN38
?ORP41:	PUSH	TBL
?THN38:	CALL	GET-OBJECT,STACK
	ZERO?	STACK /FALSE
	ZERO?	NW /TRUE
	JUMP	?CND3
?ELS27:	EQUAL?	WORD,W?AND,W?COMMA \?ELS45
	EQUAL?	NW,W?AND,W?COMMA /?ELS45
	SET	'P-AND,TRUE-VALUE
	ZERO?	BUT /?ORP53
	PUSH	BUT
	JUMP	?THN50
?ORP53:	PUSH	TBL
?THN50:	CALL	GET-OBJECT,STACK
	ZERO?	STACK \?CND12
	RFALSE	
?ELS45:	CALL	WT?,WORD,PS?BUZZ-WORD
	ZERO?	STACK /?ELS55
	JUMP	?CND3
?ELS55:	EQUAL?	WORD,W?AND,W?COMMA \?ELS57
	JUMP	?CND3
?ELS57:	EQUAL?	WORD,W?OF \?ELS59
	ZERO?	P-GETFLAGS \?CND12
	SET	'P-GETFLAGS,P-INHIBIT
	JUMP	?CND12
?ELS59:	CALL	WT?,WORD,PS?ADJECTIVE,P1?ADJECTIVE >WV
	ZERO?	WV /?ELS64
	ZERO?	P-ADJ \?ELS64
	SET	'P-ADJ,WV
	SET	'P-ADJN,WORD
	JUMP	?CND3
?ELS64:	CALL	WT?,WORD,PS?OBJECT,P1?OBJECT
	ZERO?	STACK /?CND3
	SET	'P-NAM,WORD
	SET	'P-ONEOBJ,WORD
?CND12:	
?CND3:	EQUAL?	PTR,EPTR /?PRG1
	ADD	PTR,P-WORDLEN >PTR
	SET	'WORD,NW
	JUMP	?PRG1


	.FUNCT	GET-OBJECT,TBL,VRB=1,BITS,LEN,XBITS,TLEN,GCHECK=0,OLEN=0,OBJ
	SET	'XBITS,P-SLOCBITS
	GET	TBL,P-MATCHLEN >TLEN
	BTST	P-GETFLAGS,P-INHIBIT /TRUE
	ZERO?	P-NAM \?CND4
	ZERO?	P-ADJ /?CND4
	CALL	WT?,P-ADJN,PS?OBJECT,P1?OBJECT
	ZERO?	STACK /?ELS11
	SET	'P-NAM,P-ADJN
	SET	'P-ADJ,FALSE-VALUE
	JUMP	?CND4
?ELS11:	CALL	WT?,P-ADJN,PS?DIRECTION,P1?DIRECTION >BITS
	ZERO?	BITS /?CND4
	SET	'P-ADJ,FALSE-VALUE
	PUT	TBL,P-MATCHLEN,1
	PUT	TBL,1,INTDIR
	SET	'P-WALK-DIR,BITS
	RTRUE	
?CND4:	ZERO?	P-NAM \?CND14
	ZERO?	P-ADJ \?CND14
	EQUAL?	P-GETFLAGS,P-ALL /?CND14
	ZERO?	P-GWIMBIT \?CND14
	ZERO?	VRB /FALSE
	CALL	TELL-COULDNT-FIND,STR?52
	RFALSE	
?CND14:	EQUAL?	P-GETFLAGS,P-ALL \?THN26
	ZERO?	P-SLOCBITS \?CND23
?THN26:	SET	'P-SLOCBITS,-1
?CND23:	SET	'P-TABLE,TBL
?PRG28:	ZERO?	GCHECK /?ELS32
	CALL	GLOBAL-CHECK,TBL
	JUMP	?CND30
?ELS32:	ZERO?	LIT /?CND36
	FCLEAR	PLAYER,TRANSBIT
	CALL	DO-SL,HERE,SOG,SIR
	FSET	PLAYER,TRANSBIT
?CND36:	CALL	DO-SL,PLAYER,SH,SC
?CND30:	GET	TBL,P-MATCHLEN
	SUB	STACK,TLEN >LEN
	BTST	P-GETFLAGS,P-ALL \?ELS42
	ZERO?	LEN \?CND40
	ZERO?	P-NAM /?CND40
	SET	'P-NONE,TRUE-VALUE
	JUMP	?CND40
?ELS42:	BTST	P-GETFLAGS,P-ONE \?ELS49
	ZERO?	LEN /?ELS49
	EQUAL?	LEN,1 /?CND52
	RANDOM	LEN
	GET	TBL,STACK
	PUT	TBL,1,STACK
	PRINTI	"How about the "
	GET	TBL,1
	CALL	DPRINT,STACK
	PRINTI	"?"
	CRLF	
?CND52:	PUT	TBL,P-MATCHLEN,1
	JUMP	?CND40
?ELS49:	GRTR?	LEN,1 /?THN61
	ZERO?	LEN \?ELS60
	EQUAL?	P-SLOCBITS,-1 /?ELS60
?THN61:	EQUAL?	P-SLOCBITS,-1 \?ELS67
	SET	'P-SLOCBITS,XBITS
	SET	'OLEN,LEN
	GET	TBL,P-MATCHLEN
	SUB	STACK,LEN
	PUT	TBL,P-MATCHLEN,STACK
	JUMP	?PRG28
?ELS67:	ZERO?	LEN \?CND70
	SET	'LEN,OLEN
?CND70:	ZERO?	VRB /?ELS75
	ZERO?	P-NAM /?ELS75
	EQUAL?	WINNER,PLAYER \?ELS80
	CALL	WHICH-PRINT,TLEN,LEN,TBL
	EQUAL?	TBL,P-PRSO \?ELS85
	PUSH	P-NC1
	JUMP	?CND81
?ELS85:	PUSH	P-NC2
?CND81:	SET	'P-ACLAUSE,STACK
	SET	'P-AADJ,P-ADJ
	SET	'P-ANAM,P-NAM
	CALL	ORPHAN,FALSE-VALUE,FALSE-VALUE
	SET	'P-OFLAG,TRUE-VALUE
	JUMP	?CND73
?ELS80:	CALL	REQUEST-INCOMPLETE
	PRINTI	"which"
	CALL	WHICH-PRINT-NOUN,TBL
	PRINTI	" you mean, "
	CALL	WHICH-PRINT-LIST,TLEN,LEN,TBL
	SET	'P-OFLAG,FALSE-VALUE
	PRINTI	"."
	CRLF	
	JUMP	?CND73
?ELS75:	ZERO?	VRB /?CND73
	CALL	TELL-COULDNT-FIND,STR?52
?CND73:	SET	'P-NAM,FALSE-VALUE
	SET	'P-ADJ,FALSE-VALUE
	RFALSE	
?ELS60:	ZERO?	LEN \?ELS100
	ZERO?	GCHECK /?ELS100
	ZERO?	VRB /?CND103
	ZERO?	LIT /?ELS109
	CALL	OBJ-FOUND,NOT-HERE-OBJECT,TBL
	SET	'P-XNAM,P-NAM
	SET	'P-XADJ,P-ADJ
	SET	'P-XADJN,P-ADJN
	SET	'P-NAM,FALSE-VALUE
	SET	'P-ADJ,FALSE-VALUE
	SET	'P-ADJN,FALSE-VALUE
	RTRUE	
?ELS109:	CALL	TELL-TOO-DARK
?CND103:	SET	'P-NAM,FALSE-VALUE
	SET	'P-ADJ,FALSE-VALUE
	RFALSE	
?ELS100:	ZERO?	LEN \?CND40
	SET	'GCHECK,TRUE-VALUE
	JUMP	?PRG28
?CND40:	ZERO?	P-ADJ /?ELS117
	ZERO?	P-NAM \?ELS117
	SET	'P-NONOUN,TRUE-VALUE
	JUMP	?CND115
?ELS117:	SET	'P-NONOUN,FALSE-VALUE
?CND115:	SET	'P-SLOCBITS,XBITS
	SET	'P-NAM,FALSE-VALUE
	SET	'P-ADJ,FALSE-VALUE
	RTRUE	


	.FUNCT	TELL-COULDNT-FIND,STR
	PRINTI	"I couldn't find "
	PRINT	STR
	PRINTR	" in that sentence."


	.FUNCT	TELL-TOO-DARK
	PRINTR	"It's too dark to see!"


	.FUNCT	MOBY-FIND,TBL,FOO,LEN
	SET	'P-MOBY-FLAG,TRUE-VALUE
	SET	'P-SLOCBITS,-1
	SET	'P-TABLE,TBL
	SET	'P-NAM,P-XNAM
	SET	'P-ADJ,P-XADJ
	SET	'P-MOBY-FOUND,FALSE-VALUE
	PUT	TBL,P-MATCHLEN,0
	FIRST?	ROOMS >FOO /?KLU17
?KLU17:	
?PRG1:	ZERO?	FOO \?ELS5
	JUMP	?REP2
?ELS5:	CALL	SEARCH-LIST,FOO,TBL,P-SRCALL
	NEXT?	FOO >FOO /?KLU18
?KLU18:	JUMP	?PRG1
?REP2:	GET	TBL,P-MATCHLEN >LEN
	ZERO?	LEN \?CND8
	CALL	DO-SL,LOCAL-GLOBALS,1,1
?CND8:	GET	TBL,P-MATCHLEN >LEN
	ZERO?	LEN \?CND11
	CALL	SEARCH-LIST,GLOBAL-FERRY,TBL,P-SRCTOP
?CND11:	GET	TBL,P-MATCHLEN >LEN
	EQUAL?	LEN,1 \?CND14
	GET	TBL,1 >P-MOBY-FOUND
?CND14:	SET	'P-MOBY-FLAG,FALSE-VALUE
	RETURN	LEN


	.FUNCT	WHICH-PRINT,TLEN,LEN,TBL
	PRINTI	"Which"
	CALL	WHICH-PRINT-NOUN,TBL
	PRINTI	" do you mean, "
	CALL	WHICH-PRINT-LIST,TLEN,LEN,TBL
	PRINTR	"?"


	.FUNCT	WHICH-PRINT-NOUN,TBL
	ZERO?	P-OFLAG \?THN6
	ZERO?	P-MERGED \?THN6
	ZERO?	P-AND /?ELS5
?THN6:	PRINTI	" "
	EQUAL?	P-NAM,W?INTNUM \?ELS14
	CALL	DPRINT,INTNUM
	RSTACK	
?ELS14:	PRINTB	P-NAM
	RTRUE	
?ELS5:	EQUAL?	TBL,P-PRSO \?ELS20
	CALL	CLAUSE-PRINT,P-NC1,P-NC1L,FALSE-VALUE
	RSTACK	
?ELS20:	CALL	CLAUSE-PRINT,P-NC2,P-NC2L,FALSE-VALUE
	RSTACK	


	.FUNCT	WHICH-PRINT-LIST,TLEN,LEN,TBL,OBJ,RLEN
	SET	'RLEN,LEN
?PRG1:	INC	'TLEN
	GET	TBL,TLEN >OBJ
	CALL	THE?,OBJ
	CALL	DPRINT,OBJ
	EQUAL?	LEN,2 \?ELS7
	EQUAL?	RLEN,2 /?CND8
	PRINTI	", "
?CND8:	PRINTI	" or "
	JUMP	?CND5
?ELS7:	GRTR?	LEN,2 \?CND5
	PRINTI	", "
?CND5:	DLESS?	'LEN,1 \?PRG1
	RTRUE	


	.FUNCT	GLOBAL-CHECK,TBL,LEN,RMG,RMGL,CNT=0,OBJ,OBITS
	GET	TBL,P-MATCHLEN >LEN
	SET	'OBITS,P-SLOCBITS
	GETPT	HERE,P?GLOBAL >RMG
	ZERO?	RMG /?CND1
	PTSIZE	RMG
	SUB	STACK,1 >RMGL
?PRG4:	GETB	RMG,CNT >OBJ
	CALL	THIS-IT?,OBJ,TBL
	ZERO?	STACK /?CND6
	CALL	OBJ-FOUND,OBJ,TBL
?CND6:	FSET?	OBJ,CONTBIT /?THN16
	FSET?	OBJ,SURFACEBIT \?THN16
?THN16:	FSET?	OBJ,OPENBIT /?THN12
	FSET?	OBJ,TRANSBIT \?CND9
?THN12:	CALL	SEARCH-LIST,OBJ,TBL,P-SRCTOP
?CND9:	IGRTR?	'CNT,RMGL \?PRG4
?CND1:	GETPT	HERE,P?PSEUDO >RMG
	ZERO?	RMG /?CND21
	PTSIZE	RMG
	DIV	STACK,4
	SUB	STACK,1 >RMGL
	SET	'CNT,0
?PRG24:	MUL	CNT,2
	GET	RMG,STACK
	EQUAL?	P-NAM,STACK \?ELS28
	MUL	CNT,2
	ADD	STACK,1
	GET	RMG,STACK
	PUTP	PSEUDO-OBJECT,P?ACTION,STACK
	PUTP	PSEUDO-OBJECT,P?DESCFCN,HERE
	GETP	PSEUDO-OBJECT,P?ACTION
	CALL	STACK,M-NAME
	CALL	OBJ-FOUND,PSEUDO-OBJECT,TBL
	JUMP	?CND21
?ELS28:	IGRTR?	'CNT,RMGL \?PRG24
?CND21:	GET	TBL,P-MATCHLEN
	EQUAL?	STACK,LEN \FALSE
	SET	'P-SLOCBITS,-1
	SET	'P-TABLE,TBL
	CALL	DO-SL,GLOBAL-OBJECTS,1,1
	SET	'P-SLOCBITS,OBITS
	RETURN	P-SLOCBITS


	.FUNCT	DO-SL,OBJ,BIT1,BIT2,BITS
	ADD	BIT1,BIT2
	BTST	P-SLOCBITS,STACK \?ELS5
	CALL	SEARCH-LIST,OBJ,P-TABLE,P-SRCALL
	RSTACK	
?ELS5:	BTST	P-SLOCBITS,BIT1 \?ELS12
	CALL	SEARCH-LIST,OBJ,P-TABLE,P-SRCTOP
	RSTACK	
?ELS12:	BTST	P-SLOCBITS,BIT2 \TRUE
	CALL	SEARCH-LIST,OBJ,P-TABLE,P-SRCBOT
	RSTACK	


	.FUNCT	SEARCH-LIST,OBJ,TBL,LVL,FLS,NOBJ
	FIRST?	OBJ >OBJ \FALSE
?PRG6:	EQUAL?	LVL,P-SRCBOT /?CND8
	GETPT	OBJ,P?SYNONYM
	ZERO?	STACK /?CND8
	CALL	THIS-IT?,OBJ,TBL
	ZERO?	STACK /?CND8
	CALL	OBJ-FOUND,OBJ,TBL
?CND8:	EQUAL?	LVL,P-SRCTOP \?THN18
	FSET?	OBJ,SEARCHBIT /?THN18
	FSET?	OBJ,SURFACEBIT \?CND13
?THN18:	FIRST?	OBJ >NOBJ \?CND13
	FSET?	OBJ,OPENBIT /?THN20
	FSET?	OBJ,TRANSBIT /?THN20
	ZERO?	P-MOBY-FLAG \?THN20
	FSET?	OBJ,PERSON \?CND13
	EQUAL?	OBJ,PLAYER /?CND13
?THN20:	FSET?	OBJ,SURFACEBIT \?ELS28
	PUSH	P-SRCALL
	JUMP	?CND24
?ELS28:	FSET?	OBJ,SEARCHBIT \?ELS30
	PUSH	P-SRCALL
	JUMP	?CND24
?ELS30:	PUSH	P-SRCTOP
?CND24:	CALL	SEARCH-LIST,OBJ,TBL,STACK >FLS
?CND13:	NEXT?	OBJ >OBJ /?PRG6
	RTRUE	


	.FUNCT	THIS-IT?,OBJ,TBL,SYNS,?TMP1
	FSET?	OBJ,INVISIBLE /FALSE
	ZERO?	P-NAM /?ELS5
	GETPT	OBJ,P?SYNONYM >SYNS
	PTSIZE	SYNS
	DIV	STACK,2
	SUB	STACK,1
	CALL	ZMEMQ,P-NAM,SYNS,STACK
	ZERO?	STACK /FALSE
?ELS5:	ZERO?	P-ADJ /?ELS9
	GETPT	OBJ,P?ADJECTIVE >SYNS
	ZERO?	SYNS /FALSE
	PTSIZE	SYNS
	SUB	STACK,1
	CALL	ZMEMQB,P-ADJ,SYNS,STACK
	ZERO?	STACK /FALSE
?ELS9:	ZERO?	P-GWIMBIT /TRUE
	FSET?	OBJ,P-GWIMBIT /TRUE
	RFALSE	


	.FUNCT	OBJ-FOUND,OBJ,TBL,PTR
	GET	TBL,P-MATCHLEN >PTR
	ADD	PTR,1
	PUT	TBL,STACK,OBJ
	ADD	PTR,1
	PUT	TBL,P-MATCHLEN,STACK
	RTRUE	


	.FUNCT	TAKE-CHECK
	GETB	P-SYNTAX,P-SLOC1
	CALL	ITAKE-CHECK,P-PRSO,STACK
	ZERO?	STACK /FALSE
	GETB	P-SYNTAX,P-SLOC2
	CALL	ITAKE-CHECK,P-PRSI,STACK
	RSTACK	


	.FUNCT	ITAKE-CHECK,TBL,BITS,PTR,OBJ,TAKEN
	GET	TBL,P-MATCHLEN >PTR
	ZERO?	PTR /TRUE
	BTST	BITS,SHAVE /?THN8
	BTST	BITS,STAKE \TRUE
?THN8:	
?PRG10:	DLESS?	'PTR,0 /TRUE
	ADD	PTR,1
	GET	TBL,STACK >OBJ
	EQUAL?	OBJ,IT \?CND17
	SET	'OBJ,P-IT-OBJECT
?CND17:	CALL	HELD?,OBJ
	ZERO?	STACK \?PRG10
	SET	'PRSO,OBJ
	FSET?	OBJ,TRYTAKEBIT \?ELS25
	SET	'TAKEN,TRUE-VALUE
	JUMP	?CND23
?ELS25:	EQUAL?	WINNER,PLAYER /?ELS27
	SET	'TAKEN,FALSE-VALUE
	JUMP	?CND23
?ELS27:	BTST	BITS,STAKE \?ELS29
	CALL	ITAKE,FALSE-VALUE
	EQUAL?	STACK,TRUE-VALUE \?ELS29
	SET	'TAKEN,FALSE-VALUE
	JUMP	?CND23
?ELS29:	SET	'TAKEN,TRUE-VALUE
?CND23:	ZERO?	TAKEN /?ELS36
	BTST	BITS,SHAVE \?ELS36
	EQUAL?	OBJ,GLOBAL-MONEY,RIDICULOUS-MONEY-KLUDGE /?THN42
	EQUAL?	OBJ,INTNUM \?ELS45
	ZERO?	P-DOLLAR-FLAG \?THN42
?ELS45:	EQUAL?	OBJ,IT \?ELS41
	EQUAL?	P-IT-OBJECT,RIDICULOUS-MONEY-KLUDGE,INTNUM,GLOBAL-MONEY \?ELS41
?THN42:	CALL	TELL-YOU-CANT,STR?53
	RFALSE	
?ELS41:	CALL	TELL-DONT-HAVE,FALSE-VALUE
	EQUAL?	OBJ,NOT-HERE-OBJECT \?ELS52
	PRINTI	"that."
	CRLF	
	RFALSE	
?ELS52:	CALL	THE?,OBJ
	CALL	DPRINT,OBJ
	PRINTI	"."
	CRLF	
	RFALSE	
?ELS36:	ZERO?	TAKEN \?PRG10
	EQUAL?	WINNER,PLAYER \?PRG10
	PRINTI	"(taking "
	GET	P-PRSI,P-MATCHLEN
	GRTR?	STACK,0 /?THN68
	GET	TBL,P-MATCHLEN
	GRTR?	STACK,1 \?ELS67
?THN68:	CALL	THE?,OBJ
	CALL	DPRINT,OBJ
	JUMP	?CND65
?ELS67:	PRINTI	"it"
?CND65:	PRINTI	" first)"
	CRLF	
	JUMP	?PRG10


	.FUNCT	MANY-CHECK,LOSS=0,TMP,?TMP1
	GET	P-PRSO,P-MATCHLEN
	GRTR?	STACK,1 \?ELS3
	GETB	P-SYNTAX,P-SLOC1
	BTST	STACK,SMANY /?ELS3
	SET	'LOSS,1
	JUMP	?CND1
?ELS3:	GET	P-PRSI,P-MATCHLEN
	GRTR?	STACK,1 \?CND1
	GETB	P-SYNTAX,P-SLOC2
	BTST	STACK,SMANY /?CND1
	SET	'LOSS,2
?CND1:	ZERO?	LOSS /TRUE
	CALL	TELL-YOU-CANT,STR?54,FALSE-VALUE
	EQUAL?	LOSS,2 \?CND16
	PRINTI	"in"
?CND16:	PRINTI	"direct objects with """
	GET	P-ITBL,P-VERBN >TMP
	ZERO?	TMP \?ELS25
	PRINTI	"tell"
	JUMP	?CND23
?ELS25:	ZERO?	P-OFLAG \?THN30
	ZERO?	P-MERGED /?ELS29
?THN30:	GET	TMP,0
	PRINTB	STACK
	JUMP	?CND23
?ELS29:	GETB	TMP,2 >?TMP1
	GETB	TMP,3
	CALL	WORD-PRINT,?TMP1,STACK
?CND23:	PRINTI	"""."
	CRLF	
	RFALSE	


	.FUNCT	ZMEMQ,ITM,TBL,SIZE=-1,CNT=1
	ZERO?	TBL /FALSE
	LESS?	SIZE,0 /?ELS6
	SET	'CNT,0
	JUMP	?CND4
?ELS6:	GET	TBL,0 >SIZE
?CND4:	
?PRG9:	GET	TBL,CNT
	EQUAL?	ITM,STACK /TRUE
	IGRTR?	'CNT,SIZE \?PRG9
	RFALSE	


	.FUNCT	ZMEMQB,ITM,TBL,SIZE,CNT=0
?PRG1:	GETB	TBL,CNT
	EQUAL?	ITM,STACK /TRUE
	IGRTR?	'CNT,SIZE \?PRG1
	RFALSE	


	.FUNCT	LIT?,RM,OHERE,LIT=0
	SET	'P-GWIMBIT,ONBIT
	SET	'OHERE,HERE
	SET	'HERE,RM
	FSET?	RM,ONBIT \?ELS3
	SET	'LIT,TRUE-VALUE
	JUMP	?CND1
?ELS3:	PUT	P-MERGE,P-MATCHLEN,0
	SET	'P-TABLE,P-MERGE
	SET	'P-SLOCBITS,-1
	EQUAL?	OHERE,RM \?CND6
	CALL	DO-SL,WINNER,1,1
?CND6:	CALL	DO-SL,RM,1,1
	GET	P-TABLE,P-MATCHLEN
	GRTR?	STACK,0 \?CND1
	SET	'LIT,TRUE-VALUE
?CND1:	SET	'HERE,OHERE
	SET	'P-GWIMBIT,0
	RETURN	LIT


	.FUNCT	VPRINT,TMP,?TMP1
	GET	P-OTBL,P-VERBN >TMP
	ZERO?	TMP \?ELS5
	PRINTI	"say"
	RTRUE	
?ELS5:	GETB	P-VTBL,2
	ZERO?	STACK \?ELS9
	GET	TMP,0
	PRINTB	STACK
	RTRUE	
?ELS9:	GETB	TMP,2 >?TMP1
	GETB	TMP,3
	CALL	WORD-PRINT,?TMP1,STACK
	RSTACK	


	.FUNCT	PRSO-PRINT,PTR
	GET	P-PRSO,P-MATCHLEN
	GRTR?	STACK,1 /?THN6
	ZERO?	P-MERGED \?THN6
	GET	P-ITBL,P-NC1 >PTR
	GET	PTR,0
	EQUAL?	STACK,W?IT \?ELS5
?THN6:	PRINTI	" "
	CALL	DPRINT,PRSO
	RSTACK	
?ELS5:	GET	P-ITBL,P-NC1L
	CALL	BUFFER-PRINT,PTR,STACK,FALSE-VALUE
	RSTACK	


	.FUNCT	PRSI-PRINT,PTR
	GET	P-PRSI,P-MATCHLEN
	GRTR?	STACK,1 /?THN6
	ZERO?	P-MERGED \?THN6
	GET	P-ITBL,P-NC2 >PTR
	GET	PTR,0
	EQUAL?	STACK,W?IT \?ELS5
?THN6:	PRINTI	" "
	CALL	DPRINT,PRSI
	RSTACK	
?ELS5:	GET	P-ITBL,P-NC2L
	CALL	BUFFER-PRINT,PTR,STACK,FALSE-VALUE
	RSTACK	


	.FUNCT	THE?,OBJ
	EQUAL?	OBJ,NOT-HERE-OBJECT \?ELS5
	PRINTI	"any "
	RTRUE	
?ELS5:	FSET?	OBJ,PERSON /FALSE
	EQUAL?	OBJ,PETES-PATCH /FALSE
	PRINTI	"the "
	RTRUE	


	.FUNCT	START-SENTENCE,OBJ
	EQUAL?	OBJ,WEASEL \?ELS5
	PRINTI	"The Weasel"
	RTRUE	
?ELS5:	FSET?	OBJ,PERSON /?THN10
	EQUAL?	OBJ,PETES-PATCH \?ELS9
?THN10:	CALL	DPRINT,OBJ
	RSTACK	
?ELS9:	PRINTI	"The "
	CALL	DPRINT,OBJ
	RSTACK	


	.FUNCT	TELL-DONT-HAVE,STR
	PRINTI	"You don't have "
	ZERO?	STR /FALSE
	PRINT	STR
	PRINTR	"."


	.FUNCT	TELL-NO-KEY
	CALL	TELL-DONT-HAVE,STR?55
	RSTACK	

	.ENDI
