#include <vector>
#include <ctime>

namespace XorShifts{
	class XorShift{
	private:
		unsigned x;
		unsigned y;
		unsigned z;
		unsigned w;
		unsigned t;

	public:
		static const unsigned defaultX=123456789;
		static const unsigned defaultY=362436069;
		static const unsigned defaultZ=521288629;
		static const unsigned undefaultW=88675123;
		unsigned randCount=0;
		const unsigned seedW;

		XorShift(
			unsigned w=(1103515245*time(nullptr)+12345)%0x7FFFFFFF,
			unsigned x=defaultX,
			unsigned y=defaultY,
			unsigned z=defaultZ
		):seedW(w){
			this->x=x;
			this->y=y;
			this->z=z;
			this->w=w;
		}

		unsigned rand(){
			randCount++;
			unsigned t=x^(x<<11);
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
	};
}