package bitcamp.myapp.controller;

import bitcamp.myapp.service.NotificationService;
import bitcamp.myapp.vo.Member;
import bitcamp.myapp.vo.NotiLog;
import com.fasterxml.jackson.databind.ObjectMapper;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/notification")
public class NotificationController {

  @Autowired
  NotificationService notificationService;
  @Autowired
  ServletContext context;

  {
    System.out.println("NotificationController 생성됨!");
  }

  @GetMapping("notReadNotiCount")
  public void count(HttpSession session, HttpServletResponse response) throws Exception {
    Map<String, Object> returnMap = new HashMap<>();
    returnMap.put(
        "notReadNotiCount",
        context.getAttribute(
            "notReadNotiCount" + ((Member) session.getAttribute("loginUser")).getNo()));

    try {
      response.getWriter().print(new ObjectMapper().writeValueAsString(returnMap));
    } catch (IOException ioException) {
      ioException.printStackTrace();
    }
  }

  @GetMapping("list")
  public String list(
      @RequestParam(defaultValue = "1") int page,
      @RequestParam(defaultValue = "10") int pageSize,
      Model model,
      HttpSession session) throws Exception {

    model.addAttribute("page", page);
    model.addAttribute("pageSize", pageSize);
    model.addAttribute("notiList",
        notificationService.notiLogList(
            ((Member) session.getAttribute("loginUser")).getNo(),
            pageSize,
            page));
    model.addAttribute("maxPage",
        (notificationService.notiLogCount(
            ((Member) session.getAttribute("loginUser")).getNo())
            + pageSize - 1) / pageSize);
    return "notification/list";
  }

  @GetMapping("updateState")
  public String updateState(
      @RequestParam int memberNo,
      @RequestParam int notiNo,
      @RequestParam int notiState,
      @RequestParam String url,
      HttpSession session) throws Exception {

    Member loginUser = (Member) session.getAttribute("loginUser");
    if (memberNo == loginUser.getNo()) {
      NotiLog notiLog = notificationService.getNotiLog(notiNo);
      if (notiLog.getNotiState() == 0 && notiState != 0) {
        notificationService.updateState(notiLog, notiState);
      }
    }

    return "redirect:" + url;
  }

  @PostMapping("updateAllState")
  public String updateAllState(
      int notiState,
      HttpSession session) throws Exception {

    Member loginUser = (Member) session.getAttribute("loginUser");
    notificationService.updateAllState(loginUser.getNo(), notiState);
    if (notiState != 0) {
      context.setAttribute(
          "notReadNotiCount" + loginUser.getNo(), 0);
      session.setAttribute("notReadNotiCount", 0);
    }
    return "redirect:list";
  }

}
