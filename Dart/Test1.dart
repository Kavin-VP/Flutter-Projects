void main() {
  print(Demo(2, 3)..PrintValues());
}

class Demo {
  var x;
  var y;

  Demo(this.x, this.y);

  void PrintValues() {
    print('x value ${this.x} and y value ${this.y}');
  }

  // double get xValue {
  //   return this.x;
  // }

  //getters
  double get xValue => this.x;
  double get yValue => this.y;

  //setters
  set xValue(double val) => this.x = val;
  set yValue(double val) => this.y = val;

  //To detect or react whenever code attempts to use a
  //non-existent method or instance variable, you can override noSuchMethod()

  @override
  void noSuchMethod(Invocation invocation) {
    print('No method or field found for ${invocation.memberName}');
  }

  //Mixins -> defining code that can be used in different hierarchies
  //to use mixins => use WITH keyword follwed by mixin names

  //Class modifiers
  //base, abstract, final, sealed, interface, mixin
}
