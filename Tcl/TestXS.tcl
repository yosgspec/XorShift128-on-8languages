source XorShift.tcl

apply {{} {
	#XorShift�����W�F�l���[�^�̏�����
	# �_���f�t�H���g�V�[�h
	set r_def [XorShift::defaultSeed new]
	# �Œ�l�V�[�h
	set r_var [XorShift new 100]
	# ���ԃV�[�h
	set r [XorShift new]

	#�f�t�H���g�V�[�h�l�̎擾
	puts ">> defaults"
	puts [array get XorShift::defaults]
	#for(var i in XorShift.defaults){
	#   WScript.Echo(i+":"+XorShift.defaults[i]);
	#}

	#�K�p�����V�[�h�l�̎擾
	puts ">> seeds in r"
	array set r_seeds [$r seeds]
	puts [array get r_seeds]

	#�����̐��f�[�^���擾
	puts ">> rand 0 to UInt32Max"
	for {set i 0} {$i<5} {incr i} {
		puts [$r_def rand]
	}

	#0-100�̗���(100�܂�)�𐮐��Ŏ擾
	puts ">> randInt 0 to 100"
	for {set i 0} {$i<5} {incr i} {
		puts [$r_var randInt 0 100]
	}

	#0-1�̗����𕂗V�����_�Ŏ擾
	puts ">> randFloat 0 to 1"
	for {set i 0} {$i<5} {incr i} {
		puts [$r randFloat]
	}

	#list�̃V���b�t��
	#�l�n���ƂȂ�̂Ō���list�͔j�󂳂�Ȃ�
	puts ">> shuffle list"
	set a {}
	for {set i 0} {$i<20} {incr i} {set a [concat $a $i]}

	puts [$r shuffle $a]
	puts $a

	#���̗������񂵂���
	puts ">> randCount in r"
	puts [$r randCount]

	#�R���\�[����~
	gets stdin
}}
