"use strict";

const XorShift=require("./XorShift");

(function(){
	//XorShift�����W�F�l���[�^�̏�����
	// �_���f�t�H���g�V�[�h
	const r_def=new XorShift.defaultSeed();
	// �Œ�l�V�[�h
	const r_const=new XorShift(100);
	// ���ԃV�[�h
	const r=new XorShift();

	//�f�t�H���g�V�[�h�l�̎擾
	console.log(">> defaults");
	console.log(XorShift.defaults);

	//�K�p�����V�[�h�l�̎擾
	console.log(">> seeds in r");
	console.log(r.seeds);

	//�����̐��f�[�^���擾
	console.log(">> rand 0 to UInt32Max");
	for(let i=0;i<5;i++){
		console.log(r_def.rand());
	}

	//0-100�̗���(100�܂�)�𐮐��Ŏ擾
	console.log(">> randInt 0 to 100");
	for(let i=0;i<5;i++){
		console.log(r_const.randInt(0,100));
	}

	//0-1�̗����𕂗V�����_�Ŏ擾
	console.log(">> randFloat 0 to 1");
	for(let i=0;i<5;i++){
		console.log(r.randFloat());
	}

	//�z��̃V���b�t��
	//�l�n���ƂȂ�̂Ō��̔z��͔j�󂳂�Ȃ�
	console.log(">> shuffle Array");
	var a=[...Array(20).keys()];
	console.log(r.shuffle(a));
	console.log(a);

	//���̗������񂵂���
	console.log(">> randCount in r");
	console.log(r.randCount);
})();