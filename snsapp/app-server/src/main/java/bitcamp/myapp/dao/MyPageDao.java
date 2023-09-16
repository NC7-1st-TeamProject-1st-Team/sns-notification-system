package bitcamp.myapp.dao;

import bitcamp.myapp.vo.Member;
import bitcamp.myapp.vo.MyPage;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface MyPageDao {

  int insert(MyPage myPage);

  MyPage findBy(int memberNo);

  int update(MyPage myPage);

  int delete(int memberNo);

  int insertFollow(
      @Param("followerNo") int followerNo,
      @Param("followingNo") int followingNo);

  int deleteFollow(
      @Param("followerNo") int followerNo,
      @Param("followingNo") int followingNo);

  List<Member> findAllFollowers(int memberNo);

  List<Member> findAllFollowings(int memberNo);
}