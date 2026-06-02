package com.kh.burgerstack.store;

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

import com.kh.burgerstack.common.pagination.PagingRequest;
import com.kh.burgerstack.user.LoginUser;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/store")
public class StoreController {

    @Autowired
    private StoreService storeService;

    @PostMapping("insertStore")
    public String insertStore(Store store,
            String createStockYn) {

        int result = storeService.insertStore(
                store,
                createStockYn);

        if (result > 0) {

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
            PagingRequest pi,
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

        List<SelectStoreList> list = storeService.selectStoreList(map, pi);

        model.addAttribute("count", count);
        model.addAttribute("pageInfo", pi.toPageInfo(count));
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

        LoginUser loginUser = (LoginUser) session.getAttribute("loginUser");

        model.addAttribute("loginUser", loginUser);
        model.addAttribute("store", store);
        model.addAttribute("manager", manager);

        return "store/storeDetail";
    }

    // 수정
    @PostMapping("/update")
    public String updateStore(Store store,
            HttpSession session) {

        LoginUser loginUser = (LoginUser) session.getAttribute("loginUser");

        if (loginUser == null
                || !"ADMIN".equals(loginUser.getRole())) {

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

        LoginUser loginUser = (LoginUser) session.getAttribute("loginUser");

        if (loginUser == null || !"ADMIN".equals(loginUser.getRole())) {

            return "redirect:/store/detail?storeCode=" + storeCode;
        }

        storeService.deleteStore(storeCode);

        return "redirect:/store/list";
    }

}
