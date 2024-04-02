class IndividualBar{
  final int x;
  final double y;

  IndividualBar({
    required this.x,
    required this.y
  });
}

class BarData{
  final double food;
  final double travel;
  final double leisure;
  final double work;

  BarData({
  required this.food,
  required this.travel,
  required this.leisure,
  required this.work
  });

  List<IndividualBar> barData= [];

  void initializeBarData(){
    barData.add(IndividualBar(x: 0, y: food));
    barData.add(IndividualBar(x: 1, y: travel));
    barData.add(IndividualBar(x: 2, y: leisure));
    barData.add(IndividualBar(x: 3, y: work));
  }

}