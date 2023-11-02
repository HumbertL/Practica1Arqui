#Integrantes:
#Jose Humberto
#Diego Orozco
######## Torre A -> S6 origen
######## Torre B -> S7 auxiliar
######## Torre C -> S8 destino

.text
addi s0, zero, 3 # número de discos
add t0, zero, zero
addi t1, zero, 1
addi t2, s0, -1
addi t4, zero, 32
add t5, zero, zero
lui s6,0x10010 #Tower A 0x1001000
lui s7, 0x10010
addi s7,s7,0x4 #Tower B 0x1001020
lui s8, 0x10010
addi s8,s8,0x8 #Tower C 0x1001040

CrearDiscos:
addi t0,t0,1
sw,t0,0(s6)
addi s6,s6,0x20
bge t2,t0,CrearDiscos
addi s6, s6, -32
lui s6,0x10010
jal Hanoi
jal exit

Hanoi: #Hanoi(n, from_rod, to_rod, aux_rod)
beq s0, t1, Return
#push
addi sp, sp, -20
sw s0, 0(sp)
sw s6, 4(sp)
sw s7, 8(sp)
sw s8, 12(sp)
sw ra, 16(sp)
###############mod args
addi s0, s0,-1
add t6, s7, x0
add s7, s8, x0
add s8, t6, x0
jal Hanoi #Hanoi(n-1, from_rod, aux_rod, to_rod)
#pop <- n, ra
lw ra, 16(sp)
lw s8, 12(sp)
lw s7, 8(sp)
lw s6, 4(sp)
lw s0, 0(sp)
addi sp, sp, 20

addi t5,s0,-1
slli t5, t5,5 #offset
add s9,s6,t5
add s10,s8,t5
#Move disk from rod (from_rod)
lw t3,(s9)#s6
#to rod
  sw t3, (s10)#s8
  sw zero, (s9)#s6

#push
addi sp, sp, -20
sw s0, 0(sp)
sw s6, 4(sp)
sw s7, 8(sp)
sw s8, 12(sp)
sw ra, 16(sp)
###########mod args
addi s0, s0,-1
add t6, s6, x0
add s6, s7, x0
add s7, t6, x0
jal Hanoi  #towerOfHanoi(n - 1, aux_rod, to_rod, from_rod);
#pop <- n, ra
lw ra, 16(sp)
lw s8, 12(sp)
lw s7, 8(sp)
lw s6, 4(sp)
lw s0, 0(sp)
addi sp, sp, 20
 
jalr ra ###### missing

Return:
addi t5,s0,-1
slli t5, t5,5 #offset
add s9,s6,t5
add s10,s8,t5
#Move disk from rod (from_rod)
lw t3,(s9)#s6
#to rod
  sw t3, (s10)#s8
  sw zero, (s9)#s6

jalr ra

exit: nop