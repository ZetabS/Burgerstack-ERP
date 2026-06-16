package com.kh.burgerstack.user;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.kh.burgerstack.owner.OwnerDashboardService;

import jakarta.servlet.http.HttpSession;
import com.kh.burgerstack.store.Store;

@Controller
@RequestMapping("owner")
public class OwnerController {

	@Autowired
	private BCryptPasswordEncoder bCryptPasswordEncoder;

	@Autowired
	private OwnerService ownerService;
	
	@Autowired
    private OwnerDashboardService dashboardService;

	@GetMapping("mypage")
	public String MyPageBo() {
		return "user/MyPageBO";
	}

	@PostMapping("mypage")
	public ModelAndView update(User u, ModelAndView mv, HttpSession session) {

	    if (u.getUserName() != null) u.setUserName(org.springframework.web.util.HtmlUtils.htmlEscape(u.getUserName()));
	    if (u.getEmail() != null) u.setEmail(org.springframework.web.util.HtmlUtils.htmlEscape(u.getEmail()));
	    if (u.getPhone() != null) u.setPhone(org.springframework.web.util.HtmlUtils.htmlEscape(u.getPhone()));

	    u.setUserNo(((LoginUser) session.getAttribute("loginUser")).getUserNo());

	    int result = ownerService.update(u);

	    if (result > 0) {
	        System.out.println("1");
	        session.setAttribute("User", u);
	        session.setAttribute("alertMsg", "성공적으로 정보가 수정되었습니다.");
	        mv.setViewName("redirect:/owner/dashboard");
	    } else {
	        System.out.println("2");
	        mv.addObject("errorMsg", "정보 수정에 실패하였습니다.");
	        mv.setViewName("common/errorPage");
	    }

	    return mv;
	}

	@PostMapping("ownerPassword")
	public String updatePassword(String currentPwd, String newPwd, String checkedPwd, HttpSession session) {

		LoginUser loginUser = (LoginUser) (session.getAttribute("loginUser"));

		if (!bCryptPasswordEncoder.matches(currentPwd, loginUser.getPassword())) {

			System.out.println("1");
			
			session.setAttribute("alertMsg", "현재 비밀번호와 일치하지 않습니다.");

			return "redirect:/owner/mypage";
		}

		if (!newPwd.equals(checkedPwd)) {
			
			System.out.println("2");

			session.setAttribute("alertMsg", "새 비밀번호와 일치하지 않습니다. 비밀번호 확인을 다시 해주십시오.");

			return "redirect:/owner/mypage";

		}

		String encPwd = bCryptPasswordEncoder.encode(newPwd);

		User u = new User();
		u.setUserNo(loginUser.getUserNo());
		u.setPassword(encPwd);

		int result = ownerService.updatePassword(u);

		if (result > 0) {
			
			System.out.println("3");

			loginUser.setPassword(encPwd);

			session.setAttribute("loginUser", loginUser);

			session.setAttribute("alertMsg", "비밀번호가 변경되었습니다.");

		} else {
			System.out.println("4");
			
			session.setAttribute("errorMsg", "비밀번호 변경에 실패하였습니다.");

		}

		return "redirect:/owner/mypage";
	}

	@GetMapping("dashboard")
	public String dashboardBo(Model model, HttpSession session) {

	    LoginUser loginUser = (LoginUser) session.getAttribute("loginUser");

	    if (loginUser == null) {
	        return "redirect:/login";
	    }

	    long ownerUserNo = loginUser.getUserNo();

	    Store store = dashboardService.selectStoreByOwnerUserNo(ownerUserNo);

	    if (store == null) {
	        model.addAttribute("errorMsg", "해당 점주에게 연결된 점포가 없습니다.");
	        return "common/errorPage";
	    }

	    long storeId = store.getStoreId();

	    model.addAttribute("store", store);

	    model.addAttribute("shortageCount", dashboardService.selectShortageCount(storeId));
	    model.addAttribute("todayReceiptCount", dashboardService.selectTodayReceiptCount(storeId));
	    model.addAttribute("pendingPurchaseCount", dashboardService.selectPendingPurchaseCount(storeId));
	    model.addAttribute("unansweredInquiryCount", dashboardService.selectUnansweredInquiryCount(storeId));

	    model.addAttribute("shortageList", dashboardService.selectShortageTop5(storeId));
	    model.addAttribute("todayReceiptList", dashboardService.selectTodayReceiptList(storeId));
	    model.addAttribute("purchaseStatusList", dashboardService.selectPurchaseStatusList(storeId));
	    model.addAttribute("closing", dashboardService.selectTodayClosing(storeId));

	    model.addAttribute("noticeList", dashboardService.selectNoticeList());

	    return "user/dashboardBO";
	}

}
