
#define SB(Rs,Imm,Rt,aux) 	\
	addi at, zero, 3	\	//máscara del desplazamiento (en bytes)
	addi aux, Rt, Imm	\
	and at, at, aux		\	//en at están los últimos 2 bits, valores 0,1,2,3
	addi aux, zero, 3	\	//en aux pongo el 3
	sub at, aux, at		\ 	//en at pongo 3-at, quedan 3,2,1,0
	sllv at, at, aux	\	//multiplicación por 8, at tiene 24,16,8,0
	
	addi aux, zero, 0xFF	\	//pongo un byte en la parte más baja de aux
	
	sllv Rs, Rs, at		\	//desplazar el byte a guardar
	sllv aux, aux, at	\	//desplazar la máscara
	nor aux, zero, aux	\	//negar la máscara
	
	lw at, Imm(Rt)		\	//cargo el word a enmascarar en at
	and at, at, aux		\	//enmascarar el word
	or at, at, Rs		\	//formar el word final
	sw at, Imm(Rt)
