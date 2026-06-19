package com.kh.burgerstack.inventory.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.burgerstack.common.pagination.PagingRequest;
import com.kh.burgerstack.inventory.command.ChangeInventoryCommand;
import com.kh.burgerstack.inventory.domain.InventoryTransaction;
import com.kh.burgerstack.inventory.dto.InventoryDetailViewModel;
import com.kh.burgerstack.inventory.dto.InventoryListCondition;
import com.kh.burgerstack.inventory.dto.InventoryListViewModel;
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
            InventoryListCondition condition,
            PagingRequest pagingRequest,
            HttpSession session,
            Model model) {
        LoginUser loginUser = (LoginUser) session.getAttribute("loginUser");

        InventoryListViewModel inventoryListView = inventoryService.getInventoryListView(
                condition,
                pagingRequest,
                loginUser);

        model.addAttribute("view", inventoryListView);
        return "inventory/list";
    }

    @GetMapping("/{inventoryId}/edit")
    public String editForm(
            @PathVariable int inventoryId,
            HttpSession session,
            Model model) {
        LoginUser loginUser = (LoginUser) session.getAttribute("loginUser");

        InventoryDetailViewModel view = inventoryService.getInventoryDetail(
                inventoryId,
                loginUser);

        model.addAttribute("view", view);
        return "inventory/edit";
    }

    @GetMapping("/{inventoryId}/adjust")
    public String adjustForm(
            @PathVariable Integer inventoryId,
            HttpSession session,
            Model model) {
        LoginUser loginUser = (LoginUser) session.getAttribute("loginUser");

        InventoryDetailViewModel view = inventoryService.getInventoryDetail(inventoryId, loginUser);

        model.addAttribute("view", view);
        return "inventory/adjust";
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
            Integer afterQuantity,
            String reason,
            String transactionMemo,
            HttpSession session,
            Model model) {
        LoginUser loginUser = (LoginUser) session.getAttribute("loginUser");

        inventoryService.change(
                new ChangeInventoryCommand(
                        loginUser,
                        InventoryTransaction.forAdjustment(
                                loginUser,
                                transactionMemo,
                                reason),
                        List.of(new ChangeInventoryCommand.FixedQuantityChange(
                                inventoryId,
                                afterQuantity))));

        model.addAttribute("alertMsg", "재고 조정에 성공했습니다.");
        return String.format("redirect:/%s/inventories", role);
    }
}
