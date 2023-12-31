package bitcamp.myapp.vo;

import java.util.HashSet;
import java.util.Set;

public class LoginUser extends Member {

  private HashSet<Member> followMemberSet; // 로그인 한 유저가 팔로우하는 멤버 집합
  private HashSet<Integer> likeBoardSet; // 로그인 한 유저가 좋아요를 누른 게시글 번호 집합
  private HashSet<Integer> likedGuestBookSet;  // 로그인 한 유저가 좋아요를 누른 방명록 번호 집합
  private HashSet<Integer> visitedMyPages = new HashSet<>(); // 방문한 유저를 담는 집합

  public LoginUser() {
  }

  public LoginUser(Member member) {
    this.setNo(member.getNo());
    this.setNick(member.getNick());
    this.setName(member.getName());
    this.setPassword(member.getPassword());
    this.setPhoneNumber(member.getPhoneNumber());
    this.setEmail(member.getEmail());
    this.setPhoto(member.getPhoto());
  }

  @Override
  public String toString() {
    return "LoginUser{" +
        "followMemberSet=" + followMemberSet +
        ", likeBoardSet=" + likeBoardSet +
        "} " + super.toString();
  }

  // equals() & hashCode()는 부모 클래스인 Member의 것을 사용할 것

  public Set<Member> getFollowMemberSet() {
    return followMemberSet;
  }

  public void setFollowMemberSet(HashSet<Member> followMemberSet) {
    this.followMemberSet = followMemberSet;
  }

  public Set<Integer> getLikeBoardSet() {
    return likeBoardSet;
  }

  public void setLikeBoardSet(HashSet<Integer> likeBoardSet) {
    this.likeBoardSet = likeBoardSet;
  }

  public HashSet<Integer> getLikedGuestBookSet() {
    return likedGuestBookSet;
  }

  public void setLikedGuestBookSet(HashSet<Integer> likedGuestBookSet) {
    this.likedGuestBookSet = likedGuestBookSet;
  }

  public HashSet<Integer> getVisitedMyPages() {
    return visitedMyPages;
  }

  public void setVisitedMyPages(HashSet<Integer> visitedMyPages) {
    this.visitedMyPages = visitedMyPages;
  }
}

