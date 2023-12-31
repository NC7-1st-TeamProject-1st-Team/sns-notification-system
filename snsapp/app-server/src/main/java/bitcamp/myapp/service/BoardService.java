package bitcamp.myapp.service;

import bitcamp.myapp.vo.Board;
import bitcamp.myapp.vo.BoardPhoto;
import bitcamp.myapp.vo.Member;
import java.util.List;

public interface BoardService {

  int add(Board board) throws Exception;

  List<Board> list(int category, int limit, int page) throws Exception;

  int getTotalCount(int category) throws Exception;

  Board get(int boardNo) throws Exception;

  int update(Board board) throws Exception;

  int delete(int boardNo) throws Exception;

  int increaseViewCount(int boardNo) throws Exception;

  BoardPhoto getAttachedFile(int fileNo) throws Exception;

  int deleteAttachedFile(int fileNo) throws Exception;

  int increaseLikes(int boardNo) throws Exception; // board테이블 좋아요+1

  int decreaseLikes(int boardNo) throws Exception; // board테이블 좋아요-1

  int like(Member member, Board board) throws Exception; // board_like테이블 좋아요정보 추가

  int unlike(Member member, Board board) throws Exception; // board_like테이블 좋아요정보 삭제

  List<Integer> likelist(int memberNo) throws Exception;

  List<String> boardlikelist(int boardNo) throws Exception;

  List<Board> myboardlist(int category, int writerNo, int limit, int page) throws Exception;

  List<Board> searchBoardsList(int category, String keyword, int limit, int page) throws Exception;

  int getSearchBoardsCount(String keyword);
}
