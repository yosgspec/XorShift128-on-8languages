# XorShift128-on-9languages

![AllConcole!!!!!](https://github.com/yosgspec/XorShift128-on-8languages/blob/master/XorShiftTest.PNG)
  
  
XorShift128 on C++, Dlang, C#, VB.Net, JavaScript(Node.js) ,Python3, HSP, CommonLisp, Tcl
# Is Moving!
[C++](http://rextester.com/EYPFX86053)  
[Dlang](http://rextester.com/QIFR22984)  
[C#](https://dotnetfiddle.net/mlhumR)  
[VisualBasic](https://dotnetfiddle.net/ZLrOaR)  
[JavaScript](https://paiza.io/projects/_K5qiZpBb-0l2C-oghF0Rw)  
[Python](http://rextester.com/FQDO96576)  
[CommonLisp](http://rextester.com/TRDUW96330)  
[HSP](http://hsproom.me/program/view/?p=206)  
[Tcl](http://rextester.com/ZOQO67356)

# Basic structure

    class XorShift([w: uint, x: uint, y: uint, z: uint]){
        class defaultSeed(): super(XorShift)
        
        static property defaults: Dictionary<string,uint>
        
        property seeds: Dictionary<string,uint>
        
        property randCount: uint
        
        function rand(): uint
        
        function randInt([min: int, max: int]): int
        
        function randFloat([min: float, max: float]): float
        
        function shuffle(src: array): array
    }
