# File Name: finalProjectRyanVowell.asm
# Author: Ryan Vowell
# Modification History:
# 	This code was worked on from 11/10/2018 - 11/21/2018 by the author. No modifications since.
# Procedures:
#	- These functions simply print a character or string: PrintDotData, PrintDotWord, PrintDotText,
#		PrintDolSign, PrintComma, PrintSpace, PrintColon, PrintOP, PrintCP.
#	- These functions generate automatic labels based on the starting addresses of the data and text segments:
#		GenDataLabel, GenTextLabel
#	- These functions are the main control and loops in the program:
#		Start: starts the program and runs the first steps
#		PrintData: loops through and prints data segment for Fibonacci
#		TextLoop: loops through text segment and prints the instruction name. Branches to rtype procedure or
#			different instruction formats for registers, immediates, etc.
#		Rtype: if opcode is 0, text loop goes here to process Rtype instructions. This procedure also
#			prints instructions that are in the normal rtype format: instr $rd, $rs, $rt.
#	- These functions get different fields from the 32 bit instruction numbers: PrintRd, PrintRs, PrintRt,
#		PrintImm, PrintImmAddr, PrintTarget, PrintShift, PrintCode.
#	- These functions control which fields to get based on what the instruction format is:
#		InstrOnly: 				instr
#		Jr: 					instr $rd
#		Jump:					instr target
#		TwoRegImm:				instr $rt, $rs, imm
#		OneRegImm:				instr $rt, imm
#		StoreLoad:				instr $rt, imm($rs)
#		Bgtz (also used for blez):		instr $rs, label
#		Branch:					instr $rs, $rt, label
#		Shift:					instr $rd, $rt, shamt
#		ShiftV:					instr $rd, $rt, $rs
#		RdOnly:					instr $rd
#		RsOnly:					instr $rs
#		RsRt:					instr $rs, $rt
#		Break:					instr code
		.data
BaseData:	.word
		0
BaseText:	.word
		12288
Data: 		.word
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
12,
1750335520,
1766203493,
1634627426,
543777635,
1651340654,
544436837,
979726945,
10,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0
Text:		.word	
		537395200,
		537722928,
		2376925184,
		604635137,
		1176768512,
		2903113728,
		2903113732,
		564789246,
		2366308352,
		2366373892,
		23875616,
		2903113736,
		554172420,
		556400639,
		488701945,
		537133056,
		862240,
		201329684,
		604110858,
		12,
		278560,
		346144,
		537133110,
		604110852,
		12,
		2365849600,
		604110849,
		12,
		537133108,
		604110852,
		12,
		554172420,
		556400639,
		488701943,
		65011720,
Offset:		.word
		0,
		6,
		14,
		16,
		20,
		24,
		28,
		33,
		38,
		43,
		49,
		54,
		60,
		65,
		69,
		74,
		78,
		86,
		90,
		98,
		106,
		114,
		122,
		130,
		138,
		146,
		154,
		162,
		170,
		178,
		186,
		194,
		202,
		205,
		208,
		212,
		215,
		219,
		223,
		227,
		235,
		238,
		241,
		245,
		248,
		256,
		264,
		268,
		274,
		277,
		282,
		287,
		292,
		300,
		305,
		310,
		318,
		321,
		326,
		331,
		339,
		347,
		352,
		357
OffsetR:	.word
		0,
		4,
		12,
		16,
		20,	
		25,
		33,
		38,
		43,
		46,
		51,
		56,
		61,
		69,
		75,
		83,
		88,
		93,
		98,
		103,
		108,
		116,
		124,
		132,
		140,
		145,
		151,
		155,
		160,
		168,
		176,
		184,
		192,
		196,
		201,
		205,
		210,
		214,
		217,
		221,
		225,
		233,
		241,
		245,
		250,
		258,
		266,
		274,
		282,
		286,
		291,
		295,
		300,
		304,
		312,
		316,
		324,
		332,
		340,
		348,
		356,
		364,
		372,
		380
Name:		.asciiz
		"Rtype",
		"Illegal",
		"j",
		"jal",
		"beq",
		"bne",
		"blez",
		"bgtz",
		"addi",
		"addiu",
		"slti",
		"sltiu",
		"andi",
		"ori",
		"xori",
		"lui",
		"Illegal",
		"nop",
		"Illegal",
		"Illegal",
		"Illegal",
		"Illegal",
		"Illegal",
		"Illegal",
		"Illegal",
		"Illegal",
		"Illegal",
		"Illegal",
		"Illegal",
		"Illegal",
		"Illegal",
		"Illegal",
		"lb",
		"lh",
		"lwl",
		"lw",
		"lbu",
		"lhu",
		"lwr",
		"Illegal",
		"sb",
		"sh",
		"swl",
		"sw",
		"Illegal",
		"Illegal",
		"swr",
		"cache",
		"ll",
		"lwc1",
		"lwc2",
		"pref",
		"Illegal",
		"ldc1",
		"ldc2",
		"Illegal",
		"sc",
		"swc1",
		"swc2",
		"Illegal",
		"Illegal",
		"sdc1",
		"sdc2",
		"Illegal"
NameR:		.asciiz
		"sll",
		"Illegal",
		"srl",
		"sra",
		"sllv",
		"Illegal",
		"srlv",
		"srav",
		"jr",
		"jalr",
		"movz",
		"movn",
		"syscall",
		"break",
		"Illegal",
		"sync",
		"mfhi",
		"mthi",
		"mflo",
		"mtlo",
		"Illegal",
		"Illegal",
		"Illegal",
		"Illegal",
		"mult",
		"multu",
		"div",
		"divu",
		"Illegal",
		"Illegal",
		"Illegal",
		"Illegal",
		"add",
		"addu",
		"sub",
		"subu",
		"and",
		"or",
		"xor",
		"nor",
		"Illegal",
		"Illegal",
		"slt",
		"sltu",
		"Illegal",
		"Illegal",
		"Illegal",
		"Illegal",
		"tge",
		"tgeu",
		"tlt",
		"tltu",
		"teq",
		"Illegal",
		"tne",
		"Illegal",
		"Illegal",
		"Illegal",
		"Illegal",
		"Illegal",
		"Illegal",
		"Illegal",
		"Illegal",
		"Illegal"
Line: 		.asciiz
		"\n"
Comma:		.asciiz
		","
Colon:		.asciiz
		":"
Tab:		.asciiz
		"\t"
Space:		.asciiz
		" "
DLabel:		.asciiz
		"D"
TLabel:		.asciiz
		"L"
Reg:		.asciiz
		"$"		
DotData: 	.asciiz
		".data"
DotText: 	.asciiz
		".text"
DotWord: 	.asciiz
		".word"
DotAsciiz:	.asciiz
		".asciiz"
OpenParenth:	.asciiz
		"("
ClosedParenth:	.asciiz
		")"		
		.text
# save registers are used for the various arrays
# s6 is reserved to hold the whole 32 bit instruction so it remains across procedure calls
# s7 is used to save a return address when nested jumps are used
		la $s0, Data 			# address of Data segment for Fibonacci in $s0
		la $s1, Text			# address of the Text segment for Fibonacci in $s1
		la $s2, Offset			# address of offset array for regular instructions in $s2
		la $s3, OffsetR			# address offset array for r-type instruction in $s3
		la $s4, Name			# address of Name array for regular instructions in $s4
		la $s5, NameR			# address of NameR array for r-type instructions in $s5
# Start:
# Author: Ryan Vowell
# Modification History
# 	Routine written on 11/10/2018 by the author. No modifications since.
# Description: starts by printing .data and then generates a label and prints .word. Then PrintData loops and prints
#		the data segment
# Arguments: none
Start:		jal PrintDotData		# start by printing ".data" for data segment
		jal GenDataLabel		# generate a label for the .word array
		jal PrintDotWord		# print ".word"
		j PrintData			# loop through Data and print each entry
# GenDataLabel:
# Author: Ryan Vowell
# Modification History
# 	Routine written on 11/10/2018 by the author. No modifications since.
# Description: generates generic labels for data segment based on the starting address
# Arguments: none
GenDataLabel:	la $t0, DLabel			# loads a generic Label for use
		la $t1, BaseData		# loads the starting address for the data segment into t1
		lw $t2, 0($t1)	 		# loads the value at the address in t1
		move $s7, $ra 			# move the return address to $s7 so we can return to the correct address 
		move $a0, $t0			# move Label to a0
		li $v0, 4			# load 4 into v0 in order to print a string
		syscall				# syscall to print the Label
		li $v0, 1			# load 1 into v0 in order to print an int
		move $a0, $t2			# move address into a0
		syscall				# syscall to print Address
		jal PrintColon			# print a colon
		jal PrintSpace			# print a space
		addi $t2, $t2, 4		# add four to the value in $t2 to increment the data addresses
		sw $t2, 0($t1)			# store the new incremented address back into BaseData
		jr $s7				# return to Start where we left off
# GenTextLabel:
# Author: Ryan Vowell
# Modification History
# 	Routine written on 11/10/2018 by the author. No modifications since.
# Description: generates generic labels for text segment based on the starting address
# Arguments: none
GenTextLabel:	la $t0, TLabel			# loads a generic Label for use
		la $t1, BaseText		# loads the starting address of the text segment into t1
		lw $t2, 0($t1)	 		# loads the value at the address in t1
		move $s7, $ra 			# move the return address to $s7 so we can return to the correct address 
		move $a0, $t0			# move Label to a0
		li $v0, 4			# load 4 into v0 in order to print a string
		syscall				# syscall to print the Label
		li $v0, 1			# load 1 into v0 in order to print an int
		move $a0, $t2			# move address into a0
		syscall				# syscall to print Address
		jal PrintColon			# print a colon
		jal PrintSpace			# print a space
		addi $t2, $t2, 4		# add four to the address value so it acts as a PC for text segment
		sw $t2, 0($t1)			# store the new incremented address back into BaseText
		jr $s7				# return to Start where we left off
# Print strings and chars methods:
# Author: Ryan Vowell
# Modification History
# 	Routines written on 11/10/2018 by the author. No modifications since.
# Description: these methods print a string or character before returning to the previous location in the program.
#		I combined descriptions here since they all do the the same basic funtion
# Arguments: none
PrintDotData:	la $a0, DotData			# loads DotData for use
		li $v0, 4			# load 4 into v0 in order to print a string
		syscall				# syscall to print ".data"
		la $a0, Line			# load new line character into a0
		syscall				# syscall to print a new line
		jr $ra				# return to start where we left off
PrintDotWord:	la $a0, DotWord			# loads DotWord for use
		li $v0, 4			# load 4 into v0 in order to print a string
		syscall				# syscall to print ".word"
		la $a0, Line			# load new line charcter into a0
		syscall				# syscall to print a new line
		jr $ra				# return to Start where we left off
PrintDotText:	la $a0, DotText			# load DotText for use
		li $v0, 4			# load 4 into v0 in order to print a string
		syscall				# syscall to print ".text"
		la $a0, Line			# load new line character into a0
		syscall				# syscall to print a new line
		j TextLoop			# jump t0 Text loop in order to loop through the text segment
PrintDolSign:	la $a0, Reg			# load the dollar sign in Reg for use
		li $v0, 4			# load 4 into v0 in order to print a string
		syscall				# syscall to print a dollar sign
		jr $ra				# return to prvious location
PrintComma:	la $a0, Comma			# load a Comma for use
		li $v0, 4			# load 4 into v0 in order to print a string
		syscall				# syscall to print a comma
		jr $ra				# returns to previous location
PrintSpace:	la $a0, Space			# loads a space for use
		li $v0, 4			# load 4 into v0 in order to print a string
		syscall				# syscall to print a space
		jr $ra				# return tp previous location
PrintColon:	la $a0, Colon			# loads a space for use
		li $v0, 4			# load 4 into v0 in order to print a string
		syscall				# syscall to print a space
		jr $ra				# return tp previous location
PrintOP:	la $a0, OpenParenth		# loads a space for use
		li $v0, 4			# load 4 into v0 in order to print a string
		syscall				# syscall to print a space
		jr $ra				# return tp previous location
PrintCP:	la $a0, ClosedParenth		# loads a space for use
		li $v0, 4			# load 4 into v0 in order to print a string
		syscall				# syscall to print a space
		jr $ra				# return tp previous location
# PrintData:
# Author: Ryan Vowell
# Modification History
# 	Routine written on 11/10/2018 by the author. No modifications since.
# Description: loops through and prints each element in the data array along with a generic label for each item
# Arguments: none
PrintData:	beq $s0, $s1, PrintDotText	# When fnished with Data branch to start on text segment
		jal GenDataLabel		# Generate a label for each line
		lw $t1, 0($s0)			# load the item stored at that loacation in s0 (Data) into $t1
		move $a0, $t1			# move the item into a0
		li $v0, 1			# load 1 into v0 in order to print an int
		syscall				# syscall to print the number in a0 (the number from Data)
		li $v0, 4			# load 4 into v0 in order to print a string
		jal PrintComma			# print a comma
		la $a0, Line			# load the new line character into s7
		syscall				# syscall to print a new line
		addi $s0, $s0, 4		# increments the address in $s0 in order to loop through Data
		j PrintData			# jump to the start of the routine
# PrintData:
# Author: Ryan Vowell
# Modification History
# 	Routine written on 11/12/2018 by the author. Last modified 11/21/2018.
# Description: loops through and gets each element in the text array. It then decodes to get the opcode, and if it's zero
#		it branches to rtype method. If not it prints the instruction name and then uses branches to test 
# 		the opcode, so it can go to the method for that instruction format. Ftype instructions have been
#		changed to a nop the the Name array for any opcode of 17. Offset was corrected to reflect this.
# Arguments: none
TextLoop:	beq $s1, $s2, exit		# when address for Text reaches the address of Offset, loop exits
		jal GenTextLabel		# generate a label for each line
		lw $s6, 0($s1)			# loads the word from Text to s6. This is the isntruction
		srl $t1, $s6, 26		# shift right by 26 to get the first 6 bits (the opcode) into $t1
		beq $t1, 0, rtype		# if opcode is 0 program moves to rtype procedure		
		sll $t4, $t1, 2			# multiplies the opcode by four to get the location in Offset
		add $t4, $s2, $t4		# adds the value found above to $s2 to get the address of the required Offset value
		lw $t5, 0($t4)			# loads the value from Offset into $t5
		add $t5, $t5, $s4		# adds the value from Offset ($t5) to the address of Name
		move $a0, $t5			# moves the corresponding name found above into $a0
		li $v0, 4			# loads 4 into $v0 so syscall will print a string
		syscall				# syscall to print the instruction name
		beq $t1, 2, Jump		# j
		beq $t1, 3, Jump		# jal
		beq $t1, 4, Branch		# beq
		beq $t1, 5, Branch		# bne
		beq $t1, 6, Bgtz		# blez
		beq $t1, 7, Bgtz		# bgtz
		beq $t1, 8, TwoRegImm		# addi
		beq $t1, 9, TwoRegImm		# addiu
		beq $t1, 10, TwoRegImm		# slti
		beq $t1, 11, TwoRegImm		# sltiu
		beq $t1, 12, TwoRegImm		# andi
		beq $t1, 13, TwoRegImm		# ori
		beq $t1, 14, TwoRegImm		# xori
		beq $t1, 15, OneRegImm		# lui
		beq $t1, 32, StoreLoad		# lb
		beq $t1, 33, StoreLoad		# lh
		beq $t1, 34, StoreLoad		# lwl
		beq $t1, 35, StoreLoad		# lw
		beq $t1, 36, StoreLoad		# lbu
		beq $t1, 37, StoreLoad		# lhu
		beq $t1, 38, StoreLoad		# lwr
		beq $t1, 40, StoreLoad		# sb
		beq $t1, 41, StoreLoad		# sh
		beq $t1, 42, StoreLoad		# swl
		beq $t1, 43, StoreLoad		# sw
		beq $t1, 46, StoreLoad		# swr
		beq $t1, 47, InstrOnly		# cache
		beq $t1, 48, StoreLoad		# ll
		beq $t1, 49, StoreLoad		# lwcl
		beq $t1, 50, StoreLoad		# lwc2
		beq $t1, 51, InstrOnly		# pref
		beq $t1, 53, StoreLoad		# ldcl
		beq $t1, 54, StoreLoad		# ldc2
		beq $t1, 56, StoreLoad		# sc
		beq $t1, 57, StoreLoad		# swcl
		beq $t1, 58, StoreLoad		# swc2
		beq $t1, 61, StoreLoad		# sdcl
		beq $t1, 62, StoreLoad		#sdc2
		la $a0, Line			# load new line character
		li $v0, 4			# loads 4 into $v0 so syscall will print a string
		syscall				# syscall to print a new line
		addi $s1, $s1, 4		# increments the address in $s1 in order to loop through Text
		j TextLoop			# jump to the start of the routine	
# rtype:
# Author: Ryan Vowell
# Modification History
# 	Routine written on 11/12/2018 by the author. Last modified 11/21/2018.
# Description: this method gets the function code in order to decode the rtype instructions. It then prints the 
#		instruction name and then branches to go to the method for that instruction's format. Instructions
#		following the normal 3 register format are dealt with within this method.
# Arguments: none			
rtype: 		sll $t2, $s6, 26		# shifts left to remove the first 26 bits of instruction
		srl $t9, $t2, 26		# shifts back right so the remaining 6 bits are back in the front (this is funct code)
		sll $t2, $t9, 2			# multiplies the function code by four to get address of correct offset
		add $t2, $s3, $t2		# adds offset address to the start address of Roffset
		lw $t3, 0($t2)			# load the offset value into $t3
		add $t3, $t3, $s5		# add the offset to start address of NameR
		move $a0, $t3			# moves the name into $a0 
		li $v0, 4			# loads 4 into $v0 so syscall will print a string
		syscall				# syscall to print the corresponding r-type name
		beq $t9, 0, Shift		# sll
		beq $t9, 2, Shift		# srl
		beq $t9, 3, Shift		# sra
		beq $t9, 4, ShiftV		# sllv
		beq $t9, 6, ShiftV		# srlv
		beq $t9, 7, ShiftV		# srav
		beq $t9, 8, Jr			# jr
		beq $t9, 9, Jr			# jalr
		# func codes 10-11 follow normal r type format
		beq $t9, 12, InstrOnly		# syscall
		beq $t9, 13, Break		# break
		beq $t9, 15, InstrOnly		# sync
		beq $t9, 16, RdOnly		# mfhi
		beq $t9, 17, RsOnly		# mthi
		beq $t9, 18, RdOnly		# mflo
		beq $t9, 19, RsOnly		# mflo
		beq $t9, 24, RsRt		# mult
		beq $t9, 25, RsRt		# multu
		beq $t9, 26, RsRt		# div
		beq $t9, 27, RsRt		# divu
		# func codes 32-39 and 42-43 follow normal r type format
		beq $t9, 48, RsRt		# tge
		beq $t9, 49, RsRt		# tgeu
		beq $t9, 50, RsRt		# tlt
		beq $t9, 51, RsRt		# tltu
		beq $t9, 52, RsRt		# teq
		beq $t9, 54, RsRt		# tne
		# function codes that follow the normal 3 register format continue to these next lines
		jal PrintSpace			# print a space
		jal PrintRd			# get and print rd register
		jal PrintComma			# print a comma
		jal PrintSpace			# print a space
		jal PrintRs			# get and pring rs register
		jal PrintComma			# print a comma
		jal PrintSpace			# print a space
		jal PrintRt			# get and print rt register
		la $a0, Line			# load new line character
		li $v0, 4			# loads 4 into $v0 so syscall will print a string
		syscall				# syscall to print a new line
		addi $s1, $s1, 4		# increments the address in $s1 in order to loop through Text
		j TextLoop			# jump to the start of the main TextLoop routine
# InstrOnly:
# Author: Ryan Vowell
# Modification History
# 	Routine written on 11/12/2018 by the author. Last modified 11/21/2018.
# Description: since instr name is printed before the branch this method only increments and returns back to the TextLoop
# Arguments: none
InstrOnly:	addi $s1, $s1, 4		# increments the address in $s1 in order to loop through Text
		la $a0, Line			# load new line character
		li $v0, 4			# loads 4 into $v0 so syscall will print a string
		syscall				# syscall to print a new line
		j TextLoop			# return to beginning of TextLoop
# Jr:
# Author: Ryan Vowell
# Modification History
# 	Routine written on 11/12/2018 by the author. Last modified 11/21/2018.
# Description: gets $rs for the register jumps
# Arguments: none
Jr:		jal PrintSpace			# print a space
		jal PrintRs			# get and print rs register
		addi $s1, $s1, 4		# increments the address in $s1 in order to loop through Text
		la $a0, Line			# load new line character
		li $v0, 4			# loads 4 into $v0 so syscall will print a string
		syscall				# syscall to print a new line
		j TextLoop			# return to beginning of TextLoop
# Jump:
# Author: Ryan Vowell
# Modification History
# 	Routine written on 11/12/2018 by the author. Last modified 11/21/2018.
# Description: gets target address for jumps
# Arguments: none
Jump:		jal PrintSpace			# print a space
		jal PrintTarget			# prints the label of the target address
		addi $s1, $s1, 4		# increments the address in $s1 in order to loop through Text
		la $a0, Line			# load new line character
		li $v0, 4			# loads 4 into $v0 so syscall will print a string
		syscall				# syscall to print a new line
		j TextLoop			# return to beginning of TextLoop
# TwoRegImm:
# Author: Ryan Vowell
# Modification History
# 	Routine written on 11/12/2018 by the author. Last modified 11/21/2018.
# Description: gets the two registers and immediate value 
# Arguments: none
TwoRegImm:	jal PrintSpace			# print a space
		jal PrintRt			# get and print rt register
		jal PrintComma			# print a comma
		jal PrintSpace			# print a space
		jal PrintRs			# get and print rs register
		jal PrintComma			# print a comma
		jal PrintSpace			# print a space
		jal PrintImm			# get and print the immediate value
		addi $s1, $s1, 4		# increments the address in $s1 in order to loop through Text
		la $a0, Line			# load new line character
		li $v0, 4			# loads 4 into $v0 so syscall will print a string
		syscall				# syscall to print a new line
		j TextLoop			# return to beginning of TextLoop
# OneRegImm:
# Author: Ryan Vowell
# Modification History
# 	Routine written on 11/12/2018 by the author. Last modified 11/21/2018.
# Description: gets the register and immediate value 
# Arguments: none
OneRegImm:	jal PrintSpace			# print a space
		jal PrintRt			# get and print rt register
		jal PrintComma			# print a comma
		jal PrintSpace			# print a space
		jal PrintImm			# get and print the immediate value
		addi $s1, $s1, 4		# increments the address in $s1 in order to loop through Text
		la $a0, Line			# load new line character
		li $v0, 4			# loads 4 into $v0 so syscall will print a string
		syscall				# syscall to print a new line
		j TextLoop			# return to beginning of TextLoop
# StoreLoad:
# Author: Ryan Vowell
# Modification History
# 	Routine written on 11/12/2018 by the author. Last modified 11/21/2018.
# Description: gets the destination register and the immediate for the offset into the address at rs
# Arguments: none
StoreLoad:	jal PrintSpace			# print a space
		jal PrintRt			# get and print rt register
		jal PrintComma			# print a comma
		jal PrintSpace			# print a space
		jal PrintImm			# get and print the immediate value
		jal PrintOP			# print an open parenthesis
		jal PrintRs			# get and print rs register
		jal PrintCP			# print a closed parenthesis
		addi $s1, $s1, 4		# increments the address in $s1 in order to loop through Text
		la $a0, Line			# load new line character
		li $v0, 4			# loads 4 into $v0 so syscall will print a string
		syscall				# syscall to print a new line
		j TextLoop			# return to beginning of TextLoop
# Bgtz:
# Author: Ryan Vowell
# Modification History
# 	Routine written on 11/12/2018 by the author. Last modified 11/21/2018.
# Description: gets the register to compare and the target address. Also works for blez
# Arguments: none
Bgtz:		jal PrintSpace			# print a space
		jal PrintRs			# get and print rs register
		jal PrintComma			# print a comma
		jal PrintSpace			# print a space
		jal PrintImmAddr		# get and print a label using the immediate and an address
		addi $s1, $s1, 4		# increments the address in $s1 in order to loop through Text
		la $a0, Line			# load new line character
		li $v0, 4			# loads 4 into $v0 so syscall will print a string
		syscall				# syscall to print a new line
		j TextLoop			# return to beginning of TextLoop
# Branch:
# Author: Ryan Vowell
# Modification History
# 	Routine written on 11/12/2018 by the author. Last modified 11/21/2018.
# Description: gets the two registers that are compared and the target address 
# Arguments: none
Branch:		jal PrintSpace			# print a space
		jal PrintRs			# get and print rs register
		jal PrintComma			# print a comma
		jal PrintSpace			# print a space
		jal PrintRt			# get and print rt register
		jal PrintComma			# print a comma
		jal PrintSpace			# print a space
		jal PrintImmAddr		# get and print a label using the immediate and an address
		addi $s1, $s1, 4		# increments the address in $s1 in order to loop through Text
		la $a0, Line			# load new line character
		li $v0, 4			# loads 4 into $v0 so syscall will print a string
		syscall				# syscall to print a new line
		j TextLoop			# return to beginning of TextLoop
# Shift:
# Author: Ryan Vowell
# Modification History
# 	Routine written on 11/14/2018 by the author. Last modified 11/21/2018.
# Description: gets the two registers and the shift amount 
# Arguments: none
Shift:		jal PrintSpace			# print a space
		jal PrintRd			# get and print rd register
		jal PrintComma			# print a comma
		jal PrintSpace			# print a space
		jal PrintRt			# get and print rd register
		jal PrintComma			# print a comma
		jal PrintSpace			# print a space
		jal PrintShift			# print shift amount
		addi $s1, $s1, 4		# increments the address in $s1 in order to loop through Text
		la $a0, Line			# load new line character
		li $v0, 4			# loads 4 into $v0 so syscall will print a string
		syscall				# syscall to print a new line
		j TextLoop			# return to beginning of TextLoop
# ShiftV:
# Author: Ryan Vowell
# Modification History
# 	Routine written on 11/14/2018 by the author. Last modified 11/21/2018.
# Description: gets the three register needed. rt and rs are flipped as opposed to normal 3 reg rtypes
# Arguments: none
ShiftV:		jal PrintSpace			# print a space
		jal PrintRd			# get and print rd register
		jal PrintComma			# print a comma
		jal PrintSpace			# print a space
		jal PrintRt			# get and pring rs register
		jal PrintComma			# print a comma
		jal PrintSpace			# print a space
		jal PrintRs			# get and print rt register
		la $a0, Line			# load new line character
		li $v0, 4			# loads 4 into $v0 so syscall will print a string
		syscall				# syscall to print a new line
		addi $s1, $s1, 4		# increments the address in $s1 in order to loop through Text
		j TextLoop			# jump to the start of the main TextLoop routine
# RdOnly:
# Author: Ryan Vowell
# Modification History
# 	Routine written on 11/14/2018 by the author. Last modified 11/21/2018.
# Description: gets rd 
# Arguments: none
RdOnly:		jal PrintSpace			# print a space
		jal PrintRd			# get and print rd register
		la $a0, Line			# load new line character
		li $v0, 4			# loads 4 into $v0 so syscall will print a string
		syscall				# syscall to print a new line
		addi $s1, $s1, 4		# increments the address in $s1 in order to loop through Text
		j TextLoop			# jump to the start of the main TextLoop routine
# RsOnly:
# Author: Ryan Vowell
# Modification History
# 	Routine written on 11/14/2018 by the author. Last modified 11/21/2018.
# Description: gets rs 
# Arguments: none
RsOnly:		jal PrintSpace			# print a space
		jal PrintRs			# get and print rd register
		la $a0, Line			# load new line character
		li $v0, 4			# loads 4 into $v0 so syscall will print a string
		syscall				# syscall to print a new line
		addi $s1, $s1, 4		# increments the address in $s1 in order to loop through Text
		j TextLoop			# jump to the start of the main TextLoop routine
# RsRt:
# Author: Ryan Vowell
# Modification History
# 	Routine written on 11/14/2018 by the author. Last modified 11/21/2018.
# Description: gets rs and rt
# Arguments: none
RsRt:		jal PrintSpace			# print a space
		jal PrintRs			# get and print rd register
		jal PrintComma			# print a comma
		jal PrintSpace			# print a space
		jal PrintRt			# get and print rt register
		la $a0, Line			# load new line character
		li $v0, 4			# loads 4 into $v0 so syscall will print a string
		syscall				# syscall to print a new line
		addi $s1, $s1, 4		# increments the address in $s1 in order to loop through Text
		j TextLoop			# jump to the start of the main TextLoop routine
# Break:
# Author: Ryan Vowell
# Modification History
# 	Routine written on 11/14/2018 by the author. Last modified 11/21/2018.
# Description: gets the break code
# Arguments: none
Break:		jal PrintSpace			# print a space
		jal PrintCode			# get and print the code field
		la $a0, Line			# load new line character
		li $v0, 4			# loads 4 into $v0 so syscall will print a string
		syscall				# syscall to print a new line
		addi $s1, $s1, 4		# increments the address in $s1 in order to loop through Text
		j TextLoop			# jump to the start of the main TextLoop routine
# PrintRd:
# Author: Ryan Vowell
# Modification History
# 	Routine written on 11/14/2018 by the author. Last modified 11/21/2018.
# Description: get rd by shifting out unneccessary bits and printing the dollar sign
# Arguments: none
PrintRd:	sll $t6, $s6, 16		# shift left to remove first 16 bits
		srl $t6, $t6, 27		# shift back right by 27 so you are left with rd only
		move $s7, $ra			# move the return address to $s7 so we can return to the rtype method
		jal PrintDolSign		# print a dollar sign
		move $a0, $t6 			# move the rd value into a0
		li $v0, 1			# load 1 into v0 in order to print an int
		syscall				# syscall to print the value for rd
		jr $s7				# return to previous location
# PrintRs:
# Author: Ryan Vowell
# Modification History
# 	Routine written on 11/14/2018 by the author. Last modified 11/21/2018.
# Description: get rs by shifting out unneccessary bits and printing the dollar sign
# Arguments: none
PrintRs:	sll $t6, $s6, 6			# shift left to remove first 6 bits
		srl $t6, $t6, 27		# shift back right by 27 so you are left with rs only
		move $s7, $ra			# move the return address to $s7 so we can return to the rtype method
		jal PrintDolSign		# print a dollar sign
		move $a0, $t6			# move the rs value into a0
		li $v0, 1			# load 1 into v0 in order to print an int
		syscall				# syscall to print rs value
		jr $s7				# return to previous location
# PrintRt:
# Author: Ryan Vowell
# Modification History
# 	Routine written on 11/14/2018 by the author. Last modified 11/21/2018.
# Description: get rt by shifting out unneccessary bits and printing the dollar sign
# Arguments: none
PrintRt:	sll $t6, $s6, 11		# shift left to remove first 6 bits
		srl $t6, $t6, 27		# shift back right by 27 so you are left with rs only
		move $s7, $ra			# move the return address to $s7 so we can return to the rtype method
		jal PrintDolSign		# print a dollar sign
		move $a0, $t6			# move the rs value into a0
		li $v0, 1			# load 1 into v0 in order to print an int
		syscall				# syscall to print rs value
		jr $s7				# return to previous location
# PrintImm:
# Author: Ryan Vowell
# Modification History
# 	Routine written on 11/14/2018 by the author. Last modified 11/21/2018.
# Description: get the 16 bit immediate by shifting out unneccessary bits
# Arguments: none
PrintImm:	sll $t6, $s6, 16		# remove the first 16 bits
		sra $t6, $t6, 16		# shift back right to put 16 bit immediate back in fromt
		move $a0, $t6			# move the immediate to a0
		li $v0, 1			# load 1 into v0 in order to print an int
		syscall				# syscall to print the immediate
		jr $ra				# return to previous location
# PrintImm:
# Author: Ryan Vowell
# Modification History
# 	Routine written on 11/15/2018 by the author. Last modified 11/21/2018.
# Description: get the 16 bit immediate by shifting out unneccessary bits. Then that immediate is multiplied by to be
#		for addressing. It also prints the corresponding label by getting PC + 4 in BaseText and adding the
#		immediate * 4 to it
# Arguments: none
PrintImmAddr:	sll $t6, $s6, 16		# remove the first 16 bits
		sra $t6, $t6, 16		# shift back right to put 16 bit immediate back in fromt
		sll $t6, $t6, 2			# multiply the imm by four since addresses are byte based
		la $a0, TLabel			# load the generic label for use
		li $v0, 4			# load 4 into v0 in order to print a string
		syscall				# syscall to print the generic label
		la $t7, BaseText		# load the BaseText address into t7
		lw $t7, 0($t7)			# load the value in BaseText. This is PC + 4 
		add $t7, $t6, $t7		# add the starting address and the value in t6 to get the target address
		move $a0, $t7			# move target address into a0
		li $v0, 1			# load 1 into v0 in order to print an int
		syscall				# syscall to print the target address
		jr $ra				# return to previous location
# PrintTarget:
# Author: Ryan Vowell
# Modification History
# 	Routine written on 11/15/2018 by the author. Last modified 11/21/2018.
# Description: get the 26 bit immediate by shifting out unneccessary bits. Then multiply by four for addressing.
#		Then for jumps, it takes the first four bits of PC + 4 and concatenates them with the immediate * 4 on the end.
# Arguments: none
PrintTarget:	sll $t6, $s6, 6			# remove the first 6 bits
		sra $t6, $t6, 6			# shift back right to put 26 bit immediate back in place
		sll $t6, $t6, 2			# multiply the imm by four since addresses are byte based
		la $t7, BaseText		# load the BaseText address into t7
		lw $t7, 0($t7)			# load the value in BaseText. This is PC + 4 
		srl $t7, $t7, 28		# remove the last 28 bits of PC +4
		sll $t7, $t7, 28		# shift back left to get the last four bits back in place
		add $t7, $t6, $t7		# add first four bits of PC + 4 to the target to get the target address
		la $a0, TLabel			# load generic label for use
		li $v0, 4			# load 4 into v0 in order to print a string
		syscall				# syscall to print the generic label
		move $a0, $t6			# move target address into a0 
		li $v0, 1			# load 1 into v0 in order to print an int
		syscall				# syscall to print the target address
		jr $ra				# return to previous location
# PrintShift:
# Author: Ryan Vowell
# Modification History
# 	Routine written on 11/20/2018 by the author. Last modified 11/21/2018.
# Description: get the shift amount by shifting out the unneccessary bits
# Arguments: none
PrintShift:	sll $t6, $s6, 21		# remove the first 21 bits
		srl $t6, $t6, 27		# shift back right to get 5 bit shamt in place
		move $a0, $t6			# move shamt into a0
		li $v0, 1			# load 1 into v0 in order to print an int
		syscall				# syscall to print the shamt
		jr $ra				# return to previous location
# PrintCode:
# Author: Ryan Vowell
# Modification History
# 	Routine written on 11/20/2018 by the author. Last modified 11/21/2018.
# Description: get the code number for breaks by shifting out the unneccessary bits
# Arguments: none
PrintCode:	sll $t6, $s6, 6			# remove the first 6 bits 
		srl $t6, $s6, 12		# remove the last 6 bits and put code # in place
		move $a0, $t6			# move the code # into a0
		li $v0, 1			# load 1 into v0 in order to print an int
		syscall				# syscall to print the code #
		jr $ra				# return to previous location
exit:		li $v0, 10			# loads 10 into $v0 so syscall will exit the program
		syscall				# syscall exits program
