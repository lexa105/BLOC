class Ticker {
  const Ticker();
  //Stream je
  Stream<int> tick({required int ticks}) {
    return Stream.periodic(Duration(milliseconds: 1), (x) => ticks - x - 1)
        .take(ticks);
  }
}
