package com.kh.burgerstack.store.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;

import com.kh.burgerstack.store.model.service.StoreService;
import com.kh.burgerstack.store.model.vo.Store;

@Controller
public class StoreController {

    @Autowired
    private StoreService storeService;

    @PostMapping("insertStore.st")
    public String insertStore(Store store,
                              String createStockYn) {

        int result =
                storeService.insertStore(
                        store,
                        createStockYn
                );

        if(result > 0) {

            return "redirect:/storeList.st";

        } else {

            return "common/errorPage";
        }
    }
}