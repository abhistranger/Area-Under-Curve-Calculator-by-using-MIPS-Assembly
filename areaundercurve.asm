.data

area: .double 0.0
zeropointfive: .double 0.5

.globl main

.text

main:
    li		$t0, 0		# $t0 = 0, temporarly storing the 2*area.   
    li      $v0, 5      #Input call for n
    syscall             
    move    $s0, $v0    # $s0 = n, storing value of n
    li      $t1, 0      # $t1 = 0, this is the value which will be increment after each (x,y) input till n
    ble     $s0, 0, print   #check whether n==0 or not if it is zero then program will directly go to print so to print 0 area

loadfirst:
    li      $v0, 5      #Input call for x1
    syscall
    move    $t2, $v0    #storing x1 in temporary register t2
    li      $v0, 5      #Input call for y1
    syscall
    move    $t3, $v0    #storing y1 in temporary register t3
    add		$t1, $t1, 1
    ble     $s0, 1, print   # if n==1 then after one point input it will go to print to print area 0.

loop:
    
    li      $v0, 5      #Input call for xi(2<=i<=n)
    syscall
    move    $t4, $v0    #storing xi in temporary register t4
    li      $v0, 5      #Input call for yi(2<=i<=n)
    syscall
    move 	$t5, $v0	#storing yi in temporary register t5
    
    add		$t6, $t3, $t5		# $t6 = $t3 + $t5, storing (y1+y2) in temporary register t6
    sub		$t7, $t4, $t2		# $t7 = $t4 - $t2, storing (x2-x1) in temporary register t7 
    mult	$t6, $t7			# $t6 * $t7 = Hi and Lo registers
    mflo	$t8					# copy Lo to $t8=(y1+y2)*(x2-x1)
    add		$t0, $t0, $t8		# $t0 = $t0 + $t8 adding this 2*area of these two consecutive points to the $to in which we have whole 2*area
    add		$t1, $t1, 1		    # $t1 = $t1 + 1  incrementing by 1 at each iteration of loop
    move 	$t2, $t4	        # $t2 = $t4, a we don't need t2 register value for furthur calculation we can store t4 in t2 so that t4 is avaliable to store next point
    move 	$t3, $t5	        # $t3 = $t5 , same as above for the y-coordinate
    blt		$t1, $s0, loop	    # if $t1 < $s0 then loop will run again so that all points will be covered to get the correct result as when t1==n there is no need of loop again
    
print:
    l.d     $f0, zeropointfive  #loading double value 0.5 in f0
    mtc1    $t0, $f2            
    cvt.d.w $f2, $f2            #converting int to double 
    mul.d   $f4, $f2, $f0       #multiplying the f2=2*area with 0.5 to get actual area and storing it to f4
    s.d		$f4, area		    #saving f4= final area into area defined in data 
    
    li		$v0, 3		#call for output of a double
    l.d     $f12, area  #loading double value of final area into f12
    syscall             
    li      $v0, 10     #call to end the program
    syscall
.end main


