package com.kh.burgerstack.inventory.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.burgerstack.common.pagination.PagingRequest;
import com.kh.burgerstack.inventory.dto.InventoryTransactionDetail;
import com.kh.burgerstack.inventory.dto.InventoryTransactionListSort;
import com.kh.burgerstack.inventory.dto.InventoryTransactionListView;
import com.kh.burgerstack.inventory.dto.InventoryTransactionSearchCondition;
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
            InventoryTransactionSearchCondition condition,
            InventoryTransactionListSort inventoryListSort,
            PagingRequest pagingRequest,
            HttpSession session,
            Model model) {
        LoginUser loginUser = (LoginUser) session.getAttribute("loginUser");

        InventoryTransactionListView inventoryTransactionListView = inventoryTransactionService
                .getInventoryTransactionListView(
                        condition,
                        pagingRequest,
                        loginUser);

        model.addAttribute("view", inventoryTransactionListView);
        return "inventory/inventory-transactions/list";
    }

    @GetMapping("/{inventoryTransactionId}")
    public String detail(
            @PathVariable Integer inventoryTransactionId,
            HttpSession session,
            Model model) {
        LoginUser loginUser = (LoginUser) session.getAttribute("loginUser");

        InventoryTransactionDetail detail = inventoryTransactionService.getInventoryTransactionDetail(
                inventoryTransactionId,
                loginUser);

        model.addAttribute("detail", detail);
        return "inventory/inventory-transactions/detail";
    }
}
