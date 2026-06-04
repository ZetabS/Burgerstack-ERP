package com.kh.burgerstack.user;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("owner")
public class DashboardBOController {

	@GetMapping("dashboardBO")
	public String dashboardBo() {
		System.out.println("잘 호출 되나..?");
		return "user/dashboardBO";
	}
}
