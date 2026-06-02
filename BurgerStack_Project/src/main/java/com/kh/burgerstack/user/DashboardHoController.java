package com.kh.burgerstack.user;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("user")
public class DashboardHoController {

	@GetMapping("dashboardHo")
	public String dashboardHo() {
		return "user/dashboardHo";
	}
}
