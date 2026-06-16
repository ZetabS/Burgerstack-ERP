package com.kh.burgerstack.store;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.burgerstack.common.pagination.PagingRequest;

@Controller
@RequestMapping("admin/stores")
public class StoreController {

    @Autowired
    private StoreService storeService;

    private static final String PHONE_RULE_MESSAGE =
            "서울(02)은 02-1234-5678, 그 외 지역은 031-123-4567 형식으로 입력해주세요.";

    // 점포 등록 처리
    @PostMapping("")
    public String insertStore(Store store,
                              String createStockYn,
                              String phone1,
                              String phone2,
                              String phone3,
                              String detailAddress,
                              RedirectAttributes ra) {

        if (store.getOwnerUserNo() == null) {
            keepStoreForm(ra, store, phone1, phone2, phone3, detailAddress);
            ra.addFlashAttribute("msg", "점주 계정을 선택해주세요.");
            return "redirect:/admin/stores/new";
        }

        int ownerStoreCount =
                storeService.countStoreByOwnerUserNo(store.getOwnerUserNo());

        if (ownerStoreCount > 0) {
            store.setOwnerUserNo(null);
            keepStoreForm(ra, store, phone1, phone2, phone3, detailAddress);
            ra.addFlashAttribute("msg", "이미 점포에 연결된 점주입니다.");
            return "redirect:/admin/stores/new";
        }

        String storeName =
                store.getStoreName() == null ? "" : store.getStoreName().trim();

        if (storeName.equals("")) {
            keepStoreForm(ra, store, phone1, phone2, phone3, detailAddress);
            ra.addFlashAttribute("msg", "점포명을 입력해주세요.");
            return "redirect:/admin/stores/new";
        }

        store.setStoreName(storeName);

        int duplicateCount =
                storeService.countStoreName(store.getStoreName());

        if (duplicateCount > 0) {
            keepStoreForm(ra, store, phone1, phone2, phone3, detailAddress);
            ra.addFlashAttribute("msg", "이미 등록된 점포명입니다.");
            return "redirect:/admin/stores/new";
        }

        phone1 = phone1 == null ? "" : phone1.trim();
        phone2 = phone2 == null ? "" : phone2.trim();
        phone3 = phone3 == null ? "" : phone3.trim();

        if (!isValidStorePhoneParts(phone1, phone2, phone3)) {
            keepStoreForm(ra, store, phone1, phone2, phone3, detailAddress);
            ra.addFlashAttribute("msg", PHONE_RULE_MESSAGE);
            return "redirect:/admin/stores/new";
        }

        String phone =
                phone1 + "-" + phone2 + "-" + phone3;

        int phoneCount =
                storeService.countStorePhone(phone);

        System.out.println("[점포등록] phone = " + phone);
        System.out.println("[점포등록] phoneCount = " + phoneCount);

        if (phoneCount > 0) {
            keepStoreForm(ra, store, phone1, phone2, phone3, detailAddress);
            ra.addFlashAttribute("msg", "이미 등록된 연락처입니다.");
            return "redirect:/admin/stores/new";
        }

        String address =
                store.getAddress() == null ? "" : store.getAddress().trim();

        if (detailAddress != null && !detailAddress.trim().equals("")) {
            address = address + " " + detailAddress.trim();
        }

        store.setPhone(phone);
        store.setAddress(address.trim());

        try {
            int result = storeService.insertStore(store, createStockYn);

            if (result > 0) {
                ra.addFlashAttribute("msg", "점포가 등록되었습니다.");
                return "redirect:/admin/stores";
            }

        } catch (DuplicateKeyException e) {
            ra.addFlashAttribute("msg", "이미 등록된 점포명 또는 연락처입니다.");
            keepStoreForm(ra, store, phone1, phone2, phone3, detailAddress);
            return "redirect:/admin/stores/new";
        }

        return "common/errorPage";
    }

    private void keepStoreForm(RedirectAttributes ra,
                               Store store,
                               String phone1,
                               String phone2,
                               String phone3,
                               String detailAddress) {

        ra.addFlashAttribute("store", store);
        ra.addFlashAttribute("phone1", phone1);
        ra.addFlashAttribute("phone2", phone2);
        ra.addFlashAttribute("phone3", phone3);
        ra.addFlashAttribute("detailAddress", detailAddress);

        if (store.getOwnerUserNo() != null) {
            ra.addFlashAttribute("selectedOwnerText", "선택된 점주 유지됨");
        }
    }

    // 점포 등록 화면
    @GetMapping("new")
    public String storeEnrollForm() {
        return "store/storeEnrollForm";
    }

    // 점포 목록 조회
    @GetMapping("")
    public String selectStoreList(PagingRequest pi,
                                  String status,
                                  String keyword,
                                  String sort,
                                  Model model) {

        Map<String, String> map = new HashMap<>();

        map.put("status", status);
        map.put("keyword", keyword);
        map.put("sort", sort);

        int count = storeService.selectStoreCount(map);

        List<StoreListRow> list = storeService.selectStoreList(map, pi);

        model.addAttribute("count", count);
        model.addAttribute("pageInfo", pi.toPageInfo(count));
        model.addAttribute("list", list);

        model.addAttribute("status", status);
        model.addAttribute("keyword", keyword);
        model.addAttribute("sort", sort);

        return "store/storeList";
    }

    // 점포 상세 조회
    @GetMapping("/{storeId}")
    public String selectStoreDetail(@PathVariable("storeId") Long storeId,
                                    Model model) {

        Store store = storeService.selectStoreDetail(storeId);

        model.addAttribute("store", store);

        return "store/storeDetail";
    }

    // 점포 수정 처리
    @PostMapping("/{storeId}/update")
    public String updateStore(@PathVariable("storeId") Long storeId,
                              Store store,
                              RedirectAttributes ra) {

        store.setStoreId(storeId);

        if (store.getStoreName() == null
                || store.getStoreName().trim().equals("")) {

            ra.addFlashAttribute("msg", "점포명을 입력해주세요.");
            return "redirect:/admin/stores/" + storeId;
        }

        store.setStoreName(store.getStoreName().trim());

        int storeNameCount =
                storeService.countStoreNameForUpdate(
                        storeId,
                        store.getStoreName()
                );

        if (storeNameCount > 0) {
            ra.addFlashAttribute("msg", "이미 등록된 점포명입니다.");
            return "redirect:/admin/stores/" + storeId;
        }

        if (!isValidStorePhone(store.getPhone())) {
            ra.addFlashAttribute("msg", PHONE_RULE_MESSAGE);
            return "redirect:/admin/stores/" + storeId;
        }

        int phoneCount =
                storeService.countStorePhoneForUpdate(store);

        System.out.println("[점포수정] storeId = " + storeId);
        System.out.println("[점포수정] storeName = " + store.getStoreName());
        System.out.println("[점포수정] phone = " + store.getPhone());
        System.out.println("[점포수정] phoneCount = " + phoneCount);

        if (phoneCount > 0) {
            ra.addFlashAttribute("msg", "이미 등록된 연락처입니다.");
            return "redirect:/admin/stores/" + storeId;
        }

        try {
            int result = storeService.updateStore(store);

            if (result > 0) {
                ra.addFlashAttribute("msg", "점포 정보가 수정되었습니다.");
                return "redirect:/admin/stores/" + storeId;
            }

        } catch (DuplicateKeyException e) {
            ra.addFlashAttribute("msg", "이미 등록된 점포명 또는 연락처입니다.");
            return "redirect:/admin/stores/" + storeId;
        }

        return "common/errorPage";
    }

    @GetMapping("/owners/search")
    @ResponseBody
    public Map<String, Object> searchOwner(String keyword) {

        Map<String, Object> result = new HashMap<>();

        if (keyword == null || keyword.trim().equals("")) {
            result.put("found", false);
            result.put("message", "점주 아이디를 입력해주세요.");
            return result;
        }

        Map<String, Object> owner =
                storeService.selectOwnerByLoginId(keyword.trim());

        if (owner == null) {
            result.put("found", false);
            result.put("message", "존재하지 않는 점주입니다.");
            return result;
        }

        Long ownerUserNo =
                ((Number) owner.get("ownerUserNo")).longValue();

        int ownerStoreCount =
                storeService.countStoreByOwnerUserNo(ownerUserNo);

        result.put("found", true);
        result.put("ownerUserNo", ownerUserNo);
        result.put("ownerLoginId", owner.get("ownerLoginId"));
        result.put("ownerName", owner.get("ownerName"));

        if (ownerStoreCount > 0) {
            result.put("available", false);
            result.put("message", "이미 점포에 연결된 점주입니다.");
        } else {
            result.put("available", true);
            result.put("message", "선택 가능한 점주입니다.");
        }

        return result;
    }

    @GetMapping("/check-name")
    @ResponseBody
    public Map<String, Object> checkStoreName(String storeName,
                                              Long storeId) {

        Map<String, Object> result = new HashMap<>();

        if (storeName == null || storeName.trim().equals("")) {
            result.put("available", false);
            result.put("message", "점포명을 입력해주세요.");
            return result;
        }

        storeName = storeName.trim();

        int count;

        // 등록 화면
        if (storeId == null) {
            count = storeService.countStoreName(storeName);
        }
        // 수정 화면
        else {
            count = storeService.countStoreNameForUpdate(storeId, storeName);
        }

        if (count > 0) {
            result.put("available", false);
            result.put("message", "이미 등록된 점포명입니다.");
        } else {
            result.put("available", true);
            result.put("message", "사용 가능한 점포명입니다.");
        }

        return result;
    }

    // 허용 지역번호 확인
    private boolean isAllowedAreaCode(String phone1) {

        return "02".equals(phone1)
                || "031".equals(phone1)
                || "032".equals(phone1)
                || "033".equals(phone1)
                || "041".equals(phone1)
                || "042".equals(phone1)
                || "043".equals(phone1)
                || "044".equals(phone1)
                || "051".equals(phone1)
                || "052".equals(phone1)
                || "053".equals(phone1)
                || "054".equals(phone1)
                || "055".equals(phone1)
                || "061".equals(phone1)
                || "062".equals(phone1)
                || "063".equals(phone1)
                || "064".equals(phone1);
    }

    // 등록용 연락처 검증
    private boolean isValidStorePhoneParts(String phone1,
                                           String phone2,
                                           String phone3) {

        if (phone1 == null || phone2 == null || phone3 == null) {
            return false;
        }

        if (!isAllowedAreaCode(phone1)) {
            return false;
        }

        if (!phone3.matches("\\d{4}")) {
            return false;
        }

        // 서울: 02-1234-5678
        if ("02".equals(phone1)) {
            return phone2.matches("\\d{4}");
        }

        // 서울 외 지역: 031-123-4567
        return phone1.matches("\\d{3}")
                && phone2.matches("\\d{3}");
    }

    // 수정용 연락처 검증
    private boolean isValidStorePhone(String phone) {

        if (phone == null) {
            return false;
        }

        String[] phoneArr = phone.split("-");

        if (phoneArr.length != 3) {
            return false;
        }

        String phone1 = phoneArr[0];
        String phone2 = phoneArr[1];
        String phone3 = phoneArr[2];

        return isValidStorePhoneParts(phone1, phone2, phone3);
    }

    /*
     * 폐점 처리 버튼을 없앨 거면 이 메서드는 이제 필요 없음.
     * 상태 select에서 CLOSED로 바꾸고 수정 버튼을 누르면 updateStore에서 처리됨.
     */
}