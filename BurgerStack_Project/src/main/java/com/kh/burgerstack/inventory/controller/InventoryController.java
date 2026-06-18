package com.kh.burgerstack.inventory.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.burgerstack.common.pagination.PagingRequest;
import com.kh.burgerstack.inventory.dto.InventoryAdjustRequest;
import com.kh.burgerstack.inventory.dto.InventoryAdjustmentCommand;
import com.kh.burgerstack.inventory.dto.InventoryDetail;
import com.kh.burgerstack.inventory.dto.InventoryListSort;
import com.kh.burgerstack.inventory.dto.InventoryListView;
import com.kh.burgerstack.inventory.dto.InventorySearchCondition;
import com.kh.burgerstack.inventory.service.InventoryService;
import com.kh.burgerstack.user.LoginUser;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/{role}/inventories")
@RequiredArgsConstructor
public class InventoryController {
    private final InventoryService inventoryService;

    @GetMapping
    public String list(
            InventorySearchCondition condition,
            InventoryListSort inventoryListSort,
            PagingRequest pagingRequest,
            HttpSession session,
            Model model) {
        LoginUser loginUser = (LoginUser) session.getAttribute("loginUser");

        InventoryListView inventoryListView = inventoryService.getInventoryListView(
                condition,
                pagingRequest,
                loginUser);

        model.addAttribute("view", inventoryListView);
        return "inventory/inventories/list";
    }

    @GetMapping("/{inventoryId}/edit")
    public String editForm(
            @PathVariable int inventoryId,
            HttpSession session,
            Model model) {
        LoginUser loginUser = (LoginUser) session.getAttribute("loginUser");

        InventoryDetail detail = inventoryService.getInventoryDetail(
                inventoryId,
                loginUser);

        model.addAttribute("detail", detail);
        return "inventory/inventories/edit";
    }

    @GetMapping("/{inventoryId}/adjust")
    public String adjustForm(
            @PathVariable Integer inventoryId,
            HttpSession session,
            Model model) {
        LoginUser loginUser = (LoginUser) session.getAttribute("loginUser");

        InventoryDetail detail = inventoryService.getInventoryDetail(inventoryId, loginUser);

        model.addAttribute("detail", detail);
        return "inventory/inventories/adjust";
    }

    @PostMapping("/{inventoryId}")
    public String edit(
            @PathVariable int inventoryId,
            int safetyQuantity,
            HttpSession session) {
        LoginUser loginUser = (LoginUser) session.getAttribute("loginUser");

        inventoryService.changeSafetyQuantity(
                inventoryId,
                safetyQuantity,
                loginUser);

        return "redirect:/owner/inventories";
    }

    @PostMapping("/{inventoryId}/adjust")
    public String adjust(
            @PathVariable Integer inventoryId,
            @PathVariable String role,
            InventoryAdjustRequest inventoryAdjustRequest,
            HttpSession session,
            Model model) {
        LoginUser loginUser = (LoginUser) session.getAttribute("loginUser");

        inventoryService.adjustQuantity(new InventoryAdjustmentCommand(
                inventoryId,
                inventoryAdjustRequest.getAfterQuantity(),
                inventoryAdjustRequest.getReason(),
                null,
                loginUser));

        model.addAttribute("alertMsg", "재고 조정에 성공했습니다.");
        return String.format("redirect:/%s/inventories", role);
    }
}
