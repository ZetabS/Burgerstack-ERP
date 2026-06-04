package com.kh.burgerstack.common;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import com.kh.burgerstack.user.LoginUser;

import jakarta.servlet.http.HttpSession;

@Controller
public class HomeController {

    @GetMapping("/")
    public String home(HttpSession session) {

        LoginUser loginUser =
                (LoginUser) session.getAttribute("loginUser");

        if(loginUser == null) {
            return "redirect:/auth/login";
        }

        if("ADMIN".equals(loginUser.getRole())) {
            return "redirect:/admin/dashboard";
        }

        return "redirect:/owner/dashboard";
    }
}
