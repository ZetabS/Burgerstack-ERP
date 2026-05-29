package com.kh.burgerstack.store.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.burgerstack.member.model.vo.Member;
import com.kh.burgerstack.store.model.service.StoreService;
import com.kh.burgerstack.store.model.vo.Manager;
import com.kh.burgerstack.store.model.vo.Store;

import jakarta.servlet.http.HttpSession;



@Controller
@RequestMapping("/store")
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
    
    @GetMapping("/list")
    public String selectStoreList (
    		String status,
    		String startDate,
    		String endDate,
    		String keyword,
    		Model model) {
    	
    	Map<String, String> map = new HashMap<>();
    	
    	map.put("status", status);
    	map.put("startDate", startDate);
    	map.put("endDate", endDate);
    	map.put("keyword", keyword);
    	
    	// 테이블 만들기 전 임시 화면 확인용
        model.addAttribute("count", 0);
        model.addAttribute("list", new ArrayList<>());
    	
    	// 점포 목록
    	// model.addAttribute(
    			// "count",
    			// storeService.selectStoreCount(map));
    	
    	return "store/storeListView";
    	
    }
    
    public StoreController(StoreService storeService) {
    	
    	this.storeService = storeService;
    }
    
    @GetMapping("/detail")
    public String selectStoreDetail(@RequestParam int storeCode,
    								Model model,
    								HttpSession session) {
    	
    	Store store = storeService.selectStoreDetail(storeCode);
    	Manager manager = (Manager) storeService.selectStoreManager(storeCode);
    	
    	model.addAttribute("store", store);
    	model.addAttribute("manager", manager);
    	
    	return "store/storeDetail";
    	
    }
    
    // 수정
    @PostMapping("/update")
    public String updateStore(Store store,
                              HttpSession session) {

        Member loginUser =
                (Member)session.getAttribute("loginUser");

        if(loginUser == null
            || !"ADMIN".equals(loginUser.getUserRole())) {

            return "redirect:/store/detail?storeCode="
                    + store.getStoreCode();
        }

        storeService.updateStore(store);

        return "redirect:/store/detail?storeCode="
                + store.getStoreCode();
    }
    
    // 삭제
    @GetMapping("/delete")
    public String deleteStore(@RequestParam int storeCode,
    							HttpSession session) {
    	
    	Member loginUser = (Member) session.getAttribute("loginUser");
    	
    	if(loginUser == null || !"ADMIN".equals(loginUser.getUserRole())) {
    		
    		return "redirect:/store/detail?storeCode=" + storeCode;
    	}
    	
    	storeService.deleteStore(storeCode);
    	
    	return "redirect:/store/list";
    }
    
    
    
    
    
    
    
    
}
