class FubukiCursor {
  const FubukiCursor({
    this.position = 0,
    this.row = 0,
    this.column = 0,
  });

  final int position;
  final int row;
  final int column;

  @override
  String toString() => '${row + 1}:${column + 1}@${position + 1}';

  @override
  int get hashCode => Object.hash(position, row, column);

  @override
  bool operator ==(final Object other) =>
      other is FubukiCursor && position == other.position;
}
