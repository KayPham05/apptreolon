import '../entities/board_entity.dart';
import '../repositories/i_board_repository.dart';

class GetUserBoardsUseCase {
  final IBoardRepository repository;

  GetUserBoardsUseCase(this.repository);

  Future<List<BoardEntity>> call() async {
    return await repository.getUserBoards();
  }
}
