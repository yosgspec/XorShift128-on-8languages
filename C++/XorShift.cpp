#include <stdint.h>
#include <string>
#include <vector>
#include <ctime>

namespace XorShifts{
	class XorShift{
	private:
		struct dictionary{uint32_t x;uint32_t y;uint32_t z;uint32_t w;};
		uint32_t x;
		uint32_t y;
		uint32_t z;
		uint32_t w;
		uint32_t t;

	public:
		static const struct dictionary defaults;
		uint32_t randCount=0;
		struct dictionary seeds;

		XorShift(
			uint32_t w=time(nullptr),
			uint32_t x=NULL,
			uint32_t y=NULL,
			uint32_t z=NULL
		){
			x=x!=NULL? x: w<<13;
			y=y!=NULL? y: (w>>9)^(x<<6);
			z=z!=NULL? z: y>>7;
			seeds={x,y,z,w};
			this->w=w;this->x=x;this->y=y;this->z=z;
		}

		uint32_t rand(){
			randCount++;
			uint32_t t=x^(x<<11);
			x=y;
			y=z;
			z=w;
			return w=(w^(w>>19))^(t^(t>>8));
		}

		int randInt(int min=0,int max=0x7FFFFFFF){
			return rand()%(max-min+1)+min;
		}

		float randFloat(float min=0,float max=1){
			return (float)(rand()%0xFFFF)/0xFFFF*(max-min)+min;
		}

		template<typename T>
		T* shuffle(const T* _arr,T* arr,int arrLength){
			for(int i=0;i<arrLength;i++) arr[i]=_arr[i];
			for(int i=0;i<=arrLength-2;i++){
				int r=randInt(i,arrLength-1);
				T tmp=arr[i];
				arr[i]=arr[r];
				arr[r]=tmp;
			}
			return arr;
		}

		template<typename T>
		std::vector<T> shuffle(std::vector<T> arr){
			for(int i=0;i<=arr.size()-2;i++){
				int r=randInt(i,arr.size()-1);
				T tmp=arr[i];
				arr[i]=arr[r];
				arr[r]=tmp;
			}
			return arr;
		}

		static inline XorShift defaultSeed(){
			return XorShift( 
				XorShift::defaults.w,
				XorShift::defaults.x,
				XorShift::defaults.y,
				XorShift::defaults.z
			);
		}
	};

	const struct XorShift::dictionary XorShift::defaults={
		123456789,
		362436069,
		521288629,
		88675123
	};
}