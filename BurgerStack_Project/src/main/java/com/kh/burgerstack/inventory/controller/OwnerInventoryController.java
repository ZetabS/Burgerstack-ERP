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
@RequestMapping("/owner/inventories")
@RequiredArgsConstructor
public class OwnerInventoryController {
    private final InventoryService inventoryService;

    @GetMapping
    public String list(
            InventorySearchCondition condition,
            InventoryListSort inventoryListSort,
            PagingRequest pagingRequest,
            HttpSession session,
            Model model) {
        LoginUser loginUser = (LoginUser) session.getAttribute("loginUser");
        condition.setStoreId(loginUser.getStoreId().intValue());

        InventoryListView inventoryListView = inventoryService.getInventoryListView(
                condition,
                pagingRequest,
                loginUser);

        model.addAttribute("view", inventoryListView);
        return "owner/inventories/list";
    }

    @GetMapping("/{inventoryId}/adjust")
    public String adjustForm(
            @PathVariable Integer inventoryId,
            Model model,
            HttpSession session) {
        LoginUser loginUser = (LoginUser) session.getAttribute("loginUser");

        InventoryDetail detail = inventoryService.getInventoryDetail(
                inventoryId,
                loginUser);

        model.addAttribute("detail", detail);
        return "owner/inventories/adjust";
    }

    @PostMapping("/{inventoryId}/adjust")
    public String adjust(
            @PathVariable Integer inventoryId,
            InventoryAdjustRequest inventoryAdjustRequest,
            HttpSession session,
            Model model) {
        LoginUser loginUser = (LoginUser) session.getAttribute("loginUser");

        inventoryService.adjust(inventoryId, inventoryAdjustRequest, loginUser);

        model.addAttribute("alertMsg", "재고 조정에 성공했습니다.");
        return "redirect:/owner/inventories";
    }
}
