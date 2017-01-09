# XorShift128-on-8languages
XorShift128 on C++, Dlang, C#, VB.Net, JavaScript(Node.js) ,Python3, HSP, CommonLisp

# Basic structure
  class XorShift([w: uint, x: uint, y: uint, z: uint])

  static property defaultX: uint

  static property defaultY: uint

  static property defaultZ: uint

  static property undefaultW: uint

  property seedW: uint

  property randCount: uint

  function rand(): uint

  function randInt([min: int, max: int]): int

  function randFloat([min: float, max: float]): float

  function shuffle(src: array): array
