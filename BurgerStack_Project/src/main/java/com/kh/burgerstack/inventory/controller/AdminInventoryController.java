package com.kh.burgerstack.inventory.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.burgerstack.common.pagination.PagingRequest;
import com.kh.burgerstack.inventory.dto.InventoryAdjustRequest;
import com.kh.burgerstack.inventory.dto.InventoryDetail;
import com.kh.burgerstack.inventory.dto.InventoryListSort;
import com.kh.burgerstack.inventory.dto.InventoryListView;
import com.kh.burgerstack.inventory.dto.InventorySearchCondition;
import com.kh.burgerstack.inventory.service.InventoryService;
import com.kh.burgerstack.user.LoginUser;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/admin/inventories")
@RequiredArgsConstructor
public class AdminInventoryController {
    private final InventoryService inventoryService;

    @GetMapping
    public String list(
            InventorySearchCondition condition,
            InventoryListSort inventoryListSort,
            PagingRequest pagingRequest,
            Model model) {
        InventoryListView inventoryListView = inventoryService.getInventoryListView(
                condition,
                pagingRequest);
        model.addAttribute("view", inventoryListView);
        return "admin/inventories";
    }

    @GetMapping("/{inventoryId}/edit")
    public String adjustForm(
            @PathVariable Integer inventoryId,
            Model model) {
        InventoryDetail detail = inventoryService.getInventoryDetailById(inventoryId);
        model.addAttribute("detail", detail);
        return "admin/inventories/edit";
    }

    @PostMapping("/{inventoryId}")
    public String adjust(
            @PathVariable Integer inventoryId,
            InventoryAdjustRequest inventoryAdjustRequest,
            HttpSession session,
            Model model) {
        System.out.println("called");
        LoginUser loginUser = (LoginUser) session.getAttribute("loginUser");
        inventoryService.adjust(inventoryId, loginUser, inventoryAdjustRequest);
        model.addAttribute("alertMsg", "재고 조정에 성공했습니다.");
        return "redirect:/admin/inventories/" + inventoryId + "/edit";
    }
}
