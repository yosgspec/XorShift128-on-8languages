from XorShift import XorShift

if __name__=="__main__":
	#XorShift�����W�F�l���[�^�̏�����
	# �_���f�t�H���g�V�[�h
	r_def=XorShift.defaultSeed()
	# �Œ�l�V�[�h
	r_const=XorShift(100)
	# ���ԃV�[�h
	r=XorShift()

	#�f�t�H���g�V�[�h�l�̎擾
	print(">> defaults")
	print(XorShift.defaults)

	#�K�p�����V�[�h�l�̎擾
	print(">> seeds in r")
	print(r.seeds)

	#�����̐��f�[�^���擾
	print(">> rand 0 to UInt32Max")
	for i in range(5):
		print(r_def.rand())

	#0-100�̗���(100�܂�)�𐮐��Ŏ擾
	print(">> randInt 0 to 100")
	for i in range(5):
		print(r_const.randInt(0,100))

	#0-1�̗����𕂗V�����_�Ŏ擾
	print(">> randFloat 0 to 1")
	for i in range(5):
		print(r.randFloat())

	#list�̃V���b�t��
	#�l�n���ƂȂ�̂Ō��̔z��͔j�󂳂�Ȃ�
	print(">> shuffle list")
	a=list(range(0,20))
	print(r.shuffle(a))
	print(a)

	#range�̃V���b�t��
	print(">> shuffle range")
	b=range(0,20)
	print(r.shuffle(b))
	print(b)

	#tuple(�^�v��)�̃V���b�t��
	print(">> shuffle tuple")
	c=tuple(range(0,20))
	print(r.shuffle(c))
	print(c)

	#iter(�C�e���[�^)�̃V���b�t��
	print(">> shuffle iter")
	d=iter(range(0,20))
	print([i for i in r.shuffle(d)])
	print([i for i in d])

	#���̗������񂵂���
	print(">> randCount in r")
	print(r.randCount)