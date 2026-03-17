import '../entities/board_entity.dart';

abstract class IBoardRepository {
  Future<List<BoardEntity>> getUserBoards();
}
