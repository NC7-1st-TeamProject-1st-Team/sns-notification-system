package bitcamp.myapp.dao;

import bitcamp.myapp.vo.Member;
import bitcamp.myapp.vo.MyPage;
import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface MyPageDao {

  int insert(MyPage myPage);

  MyPage findBy(int memberNo);

  int update(MyPage myPage);

  int updateCount(int memberNo);

  int delete(int memberNo);

  int insertFollow(
      @Param("followerNo") int followerNo,
      @Param("followingNo") int followingNo);

  int deleteFollow(
      @Param("followerNo") int followerNo,
      @Param("followingNo") int followingNo);

  List<Member> searchMembers(
      @Param("keyword") String keyword,
      @Param("limit") int limit,
      @Param("offset") int offset);

  int getSearchMembersCount(String keyword);

  List<Member> findAllFollowers(int memberNo);

  int getFollowerCount(int memberNo);

  List<Member> findAllFollowings(int memberNo);

  int getFollowingCount(int memberNo);
}
