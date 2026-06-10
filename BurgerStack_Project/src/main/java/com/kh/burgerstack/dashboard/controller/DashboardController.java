package com.kh.burgerstack.dashboard.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class DashboardController {
    @GetMapping({ "/admin/dashboard", "/admin/homebutton" })
    public String adminDashboard() {
        return "user/dashboardHO";
    }
}
