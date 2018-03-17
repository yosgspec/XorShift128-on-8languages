oo::class create XorShift {
	variable x
	variable y
	variable z
	variable w
	variable seeds
	method seeds {} {return [array get seeds]}
	variable randCount
	method randCount {} {return $randCount}

	constructor {
		{_w "[clock clicks -milliseconds]"}
		{_x "$w<<13"}
		{_y "($w>>9)^($x<<6)"}
		{_z "$y>>7"}
	} {
		set randCount 0
		set w [expr $_w]
		set x [expr $_x]
		set y [expr $_y]
		set z [expr $_z]

		array set seeds [list x $x y $y z $z w $w]
	}

	method rand {} {
		incr randCount
		set t [expr $x^($x<<11&0xFFFFFFFF)]
		set x $y
		set y $z
		set z $w
		return [set w [expr ($w^($w>>19))^($t^($t>>8))]]
	}

	method randInt {{min 0} {max 0x7FFFFFFF}} {
		return [expr [my rand]%($max-$min+1)+$min]
	}

	method randFloat {{min 0} {max 1}} {
		return [expr [my rand]%0xFFFF*1./0xFFFF*($max-$min)+$min]
	}

	method shuffle {arr} {
		for {set i 0} {$i<=[llength $arr]-2} {incr i} {
			set r [my randInt $i [expr [llength $arr]-1]]
			set tmp [lindex $arr $i]
			lset arr $i [lindex $arr $r]
			lset arr $r $tmp
		}
		return $arr
	}

}
namespace eval XorShift {
	variable defaults
	array set defaults {
		x 123456789
		y 362436069
		z 521288629
		w 88675123
	}
	oo::class create defaultSeed {
		superclass XorShift
		constructor {} {
			next $XorShift::defaults(w) \
				 $XorShift::defaults(x) \
				 $XorShift::defaults(y) \
				 $XorShift::defaults(z)
		}
	}
}