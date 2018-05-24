(ns XorShift)

(def defaults{
	:x 123456789
	:y 362436069
	:z 521288629
	:w 88675123
})

(defn make-XorShift
	([](make-XorShift Environment/TickCount))
	([{:keys [w x y z] :or {w Environment/TickCount,x nil,y nil,z nil}}]
		(let [x (if(= nil x) (bit-shift-left w 13) x)]
		(let [y (if(= nil y) (bit-xor (bit-shift-right w 9) (bit-shift-left x 6)) y)]
		(let [z (if(= nil z) (bit-shift-right y 7) z)]
		(let [seeds {
			:x x
			:y y
			:z z
			:w w
		}]
			(XorShift. (atom w) (atom x) (atom y) (atom z) seeds (atom 0))
		))))
	)
)
(defprotocol IXorShift
	(-rand[self])
	(randInt[self][self min max])
	(randFloat[self][self min max])
	(-shuffle[self _arr])
)
(def MXorShift{
	:-rand(fn[self]
		(swap! (:randCount self) inc)
		(let [t (bit-xor @(:x self) (bit-and (bit-shift-left @(:x self) 11) 0xFFFFFFFF))]
			(reset! (:x self) @(:y self))
			(reset! (:y self) @(:z self))
			(reset! (:z self) @(:w self))
			(reset! (:w self) (bit-xor (bit-xor @(:w self) (bit-shift-right @(:w self) 19)) (bit-xor t (bit-shift-right t 8))))
		)
	)
	:randInt(fn
		([self] (randInt self 0 0x7FFFFFFF))
		([self min max]
			(+(mod(-rand self) (inc(- max min))) min)
		)
	)
	:randFloat(fn
		([self] (randFloat self 0 1))
		([self min max]
			(+(*(float(/(mod(-rand self) 0xFFFF) 0xFFFF)) (- max min)) min)
		)
	)
	:-shuffle(fn[self _arr]
		(let [arr (map #(atom %) _arr)]
			(loop[i 0](when(< i (dec(count arr)))
				(let [r (randInt self i (dec(count arr)))]
				(let [tmp @(nth arr i)]
					(reset! (nth arr i) @(nth arr r))
					(reset! (nth arr r) tmp)
				))
			(recur(inc i))))
			(map #(deref %) arr)
		)
	)
})
(defrecord XorShift[w x y z seeds randCount])
(extend XorShift IXorShift MXorShift)

(defrecord XorShift-defaultSeed[w x y z seeds randCount])
(extend XorShift-defaultSeed IXorShift MXorShift)
(defn make-XorShift-defaultSeed[]
	(let [w (:w defaults),x (:x defaults),y (:y defaults),z (:z defaults)]
	(let [seeds {
		:x x
		:y y
		:z z
		:w w
	}]
		(XorShift-defaultSeed. (atom w) (atom x) (atom y) (atom z) seeds (atom 0))
	))
)
