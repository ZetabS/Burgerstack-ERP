package com.kh.burgerstack.store.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.burgerstack.common.model.vo.PageInfo;
import com.kh.burgerstack.common.template.Pagination;
import com.kh.burgerstack.member.model.vo.Member;
import com.kh.burgerstack.store.model.service.StoreService;
import com.kh.burgerstack.store.model.vo.Manager;
import com.kh.burgerstack.store.model.vo.SelectStoreList;
import com.kh.burgerstack.store.model.vo.Store;

import jakarta.servlet.http.HttpSession;



@Controller
@RequestMapping("/store")
public class StoreController {

    @Autowired
    private StoreService storeService;

    // 점포 등록 처리
    @PostMapping("/insertStore")
    public String insertStore(Store store,
                              String createStockYn) {

        System.out.println("ownerId = " + store.getOwnerId());

        int result = storeService.insertStore(store, createStockYn);

        System.out.println("insert result = " + result);

        if(result > 0) {
            return "redirect:/store/list";
        } else {
            return "common/errorPage";
        }
    }
    
    @GetMapping("/enroll")
    public String storeEnrollForm() {
        return "store/storeEnrollForm";
    }
    
    @GetMapping("/list")
    public String selectStoreList(
            @RequestParam(value="currentPage", defaultValue="1") int currentPage,
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

        int count = storeService.selectStoreCount(map);

        PageInfo pi = Pagination.getPageInfo(count, currentPage, 10, 10);
        
        List<SelectStoreList> list = storeService.selectStoreList(map, pi);

        model.addAttribute("count", count);
        model.addAttribute("pi", pi);
        model.addAttribute("list", list);

        return "store/storeListView";
    }
    
    public StoreController(StoreService storeService) {
    	
    	this.storeService = storeService;
    }
    
    @GetMapping("/detail")
    public String selectStoreDetail(@RequestParam("storeCode") int storeCode,
                                    Model model,
                                    HttpSession session) {

        System.out.println("넘어온 storeCode = " + storeCode);

        Store store = storeService.selectStoreDetail(storeCode);
        Manager manager = storeService.selectStoreManager(storeCode);

        Member loginUser = (Member)session.getAttribute("loginUser");

        model.addAttribute("loginUser", loginUser);
        model.addAttribute("store", store);
        model.addAttribute("manager", manager);

        return "store/storeDetail";
    }
    
    // 수정
    @PostMapping("/update")
    public String updateStore(Store store) {

        storeService.updateStore(store);

        return "redirect:/store/list";
    }
    
    // 삭제
    @GetMapping("/delete")
    public String deleteStore(@RequestParam int storeCode) {
    							
    	storeService.deleteStore(storeCode);
    	
    	return "redirect:/store/list";
    }
    
    
    
    
    
    
    
    
}
