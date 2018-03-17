source XorShift.tcl

apply {{} {
	#XorShift乱数ジェネレータの初期化
	# 論文デフォルトシード
	set r_def [XorShift::defaultSeed new]
	# 固定値シード
	set r_var [XorShift new 100]
	# 時間シード
	set r [XorShift new]

	#デフォルトシード値の取得
	puts ">> defaults"
	puts [array get XorShift::defaults]
	#for(var i in XorShift.defaults){
	#   WScript.Echo(i+":"+XorShift.defaults[i]);
	#}

	#適用したシード値の取得
	puts ">> seeds in r"
	array set r_seeds [$r seeds]
	puts [array get r_seeds]

	#乱数の生データを取得
	puts ">> rand 0 to UInt32Max"
	for {set i 0} {$i<5} {incr i} {
		puts [$r_def rand]
	}

	#0-100の乱数(100含む)を整数で取得
	puts ">> randInt 0 to 100"
	for {set i 0} {$i<5} {incr i} {
		puts [$r_var randInt 0 100]
	}

	#0-1の乱数を浮遊小数点で取得
	puts ">> randFloat 0 to 1"
	for {set i 0} {$i<5} {incr i} {
		puts [$r randFloat]
	}

	#listのシャッフル
	#値渡しとなるので元のlistは破壊されない
	puts ">> shuffle list"
	set a {}
	for {set i 0} {$i<20} {incr i} {set a [concat $a $i]}

	puts [$r shuffle $a]
	puts $a

	#今の乱数を回した回数
	puts ">> randCount in r"
	puts [$r randCount]

	#コンソール停止
	gets stdin
}}
