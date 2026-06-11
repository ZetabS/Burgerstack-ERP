package com.kh.burgerstack.dashboard.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.kh.burgerstack.dashboard.dto.AdminDashboardView;
import com.kh.burgerstack.dashboard.service.AdminDashboardService;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class AdminDashboardController {
    private final AdminDashboardService adminDashboardService;

    @GetMapping({ "/admin/dashboard", "/admin/homebutton" })
    public String adminDashboard(Model model) {
        AdminDashboardView adminDashboardView = adminDashboardService.getAdminDashboardView();
        model.addAttribute("view", adminDashboardView);
        return "user/dashboardHO";
    }
}
