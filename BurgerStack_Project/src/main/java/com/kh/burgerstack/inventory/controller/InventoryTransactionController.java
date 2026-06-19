package com.kh.burgerstack.inventory.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.burgerstack.common.pagination.PagingRequest;
import com.kh.burgerstack.inventory.dto.InventoryTransactionDetailViewModel;
import com.kh.burgerstack.inventory.dto.InventoryTransactionListViewModel;
import com.kh.burgerstack.inventory.dto.InventoryTransactionListCondition;
import com.kh.burgerstack.inventory.service.InventoryTransactionService;
import com.kh.burgerstack.user.LoginUser;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/{role}/inventory-transactions")
@RequiredArgsConstructor
public class InventoryTransactionController {
    private final InventoryTransactionService inventoryTransactionService;

    @GetMapping
    public String list(
            InventoryTransactionListCondition condition,
            PagingRequest pagingRequest,
            HttpSession session,
            Model model) {
        LoginUser loginUser = (LoginUser) session.getAttribute("loginUser");

        InventoryTransactionListViewModel inventoryTransactionListView = inventoryTransactionService
                .getInventoryTransactionListView(
                        condition,
                        pagingRequest,
                        loginUser);

        model.addAttribute("view", inventoryTransactionListView);
        return "inventory-transaction/list";
    }

    @GetMapping("/{inventoryTransactionId}")
    public String detail(
            @PathVariable Integer inventoryTransactionId,
            HttpSession session,
            Model model) {
        LoginUser loginUser = (LoginUser) session.getAttribute("loginUser");

        InventoryTransactionDetailViewModel view = inventoryTransactionService.getInventoryTransactionDetail(
                inventoryTransactionId,
                loginUser);

        model.addAttribute("view", view);
        return "inventory-transaction/detail";
    }
}
