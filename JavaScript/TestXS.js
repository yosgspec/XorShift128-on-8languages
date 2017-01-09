"use strict";

const XorShift=require("./XorShift");

(function(){
	//乱数の生データを取得
	const rW=new XorShift(XorShift.undefaultW);
	console.log(">> rand 0 to UInt32Max");
	for(let i=0;i<5;i++){
		console.log(rW.rand());
	}

	//0-100の乱数(100含む)を整数で取得
	const r=new XorShift();
	console.log(">> randInt 0 to 100");
	for(let i=0;i<5;i++){
		console.log(r.randInt(0,100));
	}

	//0-1の乱数を浮遊小数点で取得
	console.log(">> randFloat 0 to 1");
	for(let i=0;i<5;i++){
		console.log(r.randFloat());
	}

	//配列のシャッフル
	console.log(">> shuffle Array");
	var a=[...Array(20).keys()];
	console.log(r.shuffle(a));
	console.log(a);

	//デフォルトのシード値を取得
	console.log(">> defaults");
	console.log(XorShift.defaultX);
	console.log(XorShift.defaultY);
	console.log(XorShift.defaultZ);
	console.log(XorShift.undefaultW);

	//今の乱数に与えたシード値初期値(wのみ)
	console.log(">> seedW");
	console.log(r.seedW);

	//今の乱数を回した回数
	console.log(">> randCount");
	console.log(r.randCount);
})();