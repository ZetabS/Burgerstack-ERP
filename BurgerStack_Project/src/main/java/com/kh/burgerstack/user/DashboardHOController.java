package com.kh.burgerstack.user;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("admin")
public class DashboardHOController {

	@GetMapping("dashboardHO")
	public String dashboardHo() {
		return "user/dashboardHO";
	}
}
