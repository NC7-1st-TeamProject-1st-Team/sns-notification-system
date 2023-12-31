package bitcamp.myapp.service;

import bitcamp.myapp.vo.NotiLog;
import bitcamp.myapp.vo.NotiType;
import java.util.List;

public interface NotificationService {

  int add(NotiLog notiLog) throws Exception;

  List<NotiLog> notiLogList(int memberNo, int limit, int page) throws Exception;

  int notiLogCount(int memberNo) throws Exception;

  int notReadNotiLogCount(int memberNo) throws Exception;

  NotiLog getNotiLog(int notiNo) throws Exception;

  int updateState(NotiLog notiLog, int notiState) throws Exception;

  int updateAllState(int memberNo, int notiState);

  List<NotiType> notiTypeList() throws Exception;

  String getNotiTypeName(int notiTypeNo);
}