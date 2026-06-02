package com.kh.burgerstack.user;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("user")
public class DashboardHoController {

	@GetMapping("dashboardHo")
	public String dashboardHo() {
		System.out.println("잘 호출 되나..?");
		return "user/dashboardHo";
	}
}
