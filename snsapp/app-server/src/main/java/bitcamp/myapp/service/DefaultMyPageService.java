package bitcamp.myapp.service;

import bitcamp.myapp.dao.MyPageDao;
import bitcamp.myapp.vo.Member;
import bitcamp.myapp.vo.MyPage;
import bitcamp.myapp.vo.NotiLog;
import bitcamp.myapp.vo.NotiType;
import java.util.List;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class DefaultMyPageService implements MyPageService {

  MyPageDao myPageDao;

  NotificationService notificationService;

  {
    System.out.println("DefaultMyPageService 생성됨!");
  }

  public DefaultMyPageService(MyPageDao myPageDao, NotificationService notificationService) {
    this.myPageDao = myPageDao;
    this.notificationService = notificationService;
  }

  @Transactional
  @Override
  public int add(MyPage myPage) throws Exception {
    return myPageDao.insert(myPage);
  }

  @Override
  public MyPage get(int memberNo) throws Exception {
    return myPageDao.findBy(memberNo);
  }

  @Transactional
  @Override
  public int update(MyPage myPage) throws Exception {
    return myPageDao.update(myPage);
  }

  @Transactional
  @Override
  public int increaseVisitCount(int memberNo) throws Exception {
    return myPageDao.updateCount(memberNo);
  }

  @Transactional
  @Override
  public int delete(int memberNo) throws Exception {
    return myPageDao.delete(memberNo);
  }

  @Transactional
  @Override
  public int follow(Member follower, int followingNo) throws Exception {
    if (follower.getNo() == followingNo) {
      return 0;
    }
    int result = myPageDao.insertFollow(follower.getNo(), followingNo);
    notificationService.add(new NotiLog(
        followingNo,
        NotiType.FOLLOW_TYPE,
        follower.getNick() + "님이 회원님을 팔로우 했습니다.",
        "/myPage/" + follower.getNo()));
    return result;
  }

  @Transactional
  @Override
  public int unfollow(Member follower, int followingNo) throws Exception {
    int result = myPageDao.deleteFollow(follower.getNo(), followingNo);
//    notificationService.add(new NotiLog(
//        followingNo,
//        NotiType.FOLLOW_TYPE,
//        follower.getNick() + "님이 회원님을 팔로우 취소 했습니다.",
//        "/myPage/" + follower.getNo()));
    return result;
  }

  @Override
  public List<Member> searchMembersList(String keyword, int limit, int page) throws Exception {
    return myPageDao.searchMembers(keyword, limit, limit * (page - 1));
  }

  @Override
  public int getSearchMembersCount(String keyword) {
    return myPageDao.getSearchMembersCount(keyword);
  }

  @Override
  public List<Member> followerList(int memberNo) throws Exception {
    return myPageDao.findAllFollowers(memberNo);
  }

  @Override
  public int getFollowerCount(int memberNo) {
    return myPageDao.getFollowerCount(memberNo);
  }

  @Override
  public List<Member> followingList(int memberNo) throws Exception {
    return myPageDao.findAllFollowings(memberNo);
  }

  @Override
  public int getFollowingCount(int memberNo) {
    return myPageDao.getFollowingCount(memberNo);
  }
}
