package com.kh.burgerstack.store;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.kh.burgerstack.user.LoginUser;

import jakarta.servlet.http.HttpSession;

@Controller
public class OwnerStoreController {

    @Autowired
    private StoreService storeService;

 // 점주 - 내 점포 정보 조회
    @GetMapping("/owner/store")
    public String ownerStoreInfo(HttpSession session,
                                 Model model) {

        LoginUser loginUser =
                (LoginUser) session.getAttribute("loginUser");

        if (loginUser == null) {
            return "redirect:/login";
        }

        Long ownerUserNo = loginUser.getUserNo();

        Store ownerStore =
                storeService.selectStoreByOwnerUserNo(ownerUserNo);

        if (ownerStore == null) {
            model.addAttribute("errorMsg", "연결된 점포 정보가 없습니다.");
            return "common/errorPage";
        }

        Long storeId = ownerStore.getStoreId();

        Store store = storeService.selectStoreDetail(storeId);

        model.addAttribute("store", store);

        return "owner/storeList";
    }
}