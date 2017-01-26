"use strict";

const XorShift=require("./XorShift");

(function(){
	//XorShift乱数ジェネレータの初期化
	// 論文デフォルトシード
	const r_def=new XorShift.defaultSeed();
	// 固定値シード
	const r_const=new XorShift(100);
	// 時間シード
	const r=new XorShift();

	//デフォルトシード値の取得
	console.log(">> defaults");
	console.log(XorShift.defaults);

	//適用したシード値の取得
	console.log(">> seeds in r");
	console.log(r.seeds);

	//乱数の生データを取得
	console.log(">> rand 0 to UInt32Max");
	for(let i=0;i<5;i++){
		console.log(r_def.rand());
	}

	//0-100の乱数(100含む)を整数で取得
	console.log(">> randInt 0 to 100");
	for(let i=0;i<5;i++){
		console.log(r_const.randInt(0,100));
	}

	//0-1の乱数を浮遊小数点で取得
	console.log(">> randFloat 0 to 1");
	for(let i=0;i<5;i++){
		console.log(r.randFloat());
	}

	//配列のシャッフル
	//値渡しとなるので元の配列は破壊されない
	console.log(">> shuffle Array");
	var a=[...Array(20).keys()];
	console.log(r.shuffle(a));
	console.log(a);

	//今の乱数を回した回数
	console.log(">> randCount in r");
	console.log(r.randCount);
})();