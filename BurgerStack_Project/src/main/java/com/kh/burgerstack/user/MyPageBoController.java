package com.kh.burgerstack.user;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("owner")
public class MyPageBoController {

	@GetMapping("mypage")
	public String MyPageBo() {
		return "user/MyPageBo";
	}
}
