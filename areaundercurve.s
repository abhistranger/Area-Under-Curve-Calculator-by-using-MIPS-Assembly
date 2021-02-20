.data

area: .double 0.0
zeropointfive: .double 0.5

.globl main

.text

main:
    li		$t0, 0		# $t8 = 0   
    li      $v0, 5
    syscall
    move    $s0, $v0
    li      $t1, 0
    ble     $s0, 0, print

load:
    li      $v0, 5
    syscall
    move    $t2, $v0
    li      $v0, 5
    syscall
    move    $t3, $v0
    add		$t1, $t1, 1
    ble     $s0, 1, print

loop:
    
    li      $v0, 5
    syscall
    move    $t4, $v0
    li      $v0, 5
    syscall
    move 	$t5, $v0		    # $s5 = $v0
    
    add		$t6, $t3, $t5		# $t0 = $t1 + $t2
    sub		$t7, $t4, $t2		# $t0 = $t1 - $t2
    mult	$t6, $t7			# $t0 * $t1 = Hi and Lo registers
    mflo	$t8					# copy Lo to $t2
    add		$t0, $t0, $t8		    # = $t1 + $t2
    add		$t1, $t1, 1		    # $t0 = $t1 + $t2
    move 	$t2, $t4	        # $t1 = $3
    move 	$t3, $t5	        # $t2 = $4 
    blt		$t1, $s0, loop	# if $t2 <$s1t1 then target
    
print:
    l.d     $f0, zeropointfive
    mtc1    $t0, $f2
    cvt.d.w $f2, $f2
    mul.d   $f4, $f2, $f0
    s.d		$f4, area		# 
    
    li		$v0, 3		# $v0 =1 
    l.d     $f12, area
    syscall
    li      $v0, 10
    syscall
.end main


