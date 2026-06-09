package com.kh.burgerstack.material;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.kh.burgerstack.common.template.XssDefencePolicy;
import com.kh.burgerstack.file.FileStore;
import com.kh.burgerstack.file.StoredFile;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/admin/materials")
public class MaterialController {

    @Autowired
    private MaterialService materialService;

    @Autowired
    private FileStore fileStore;

    @GetMapping("new")
    public String materialEnrollform() {
        return "material/materialEnrollForm";
    }

    /**
     * 자재 등록
     */
    @PostMapping({"", "/"})
    public String materialInsert(
            Material m,
            @RequestParam(value = "materialImage", required = false) MultipartFile imageFile,
            HttpSession session) {

        try {
            // XSS 방어
            m.setMaterialName(XssDefencePolicy.defence(m.getMaterialName()));
            if (m.getDetails() != null) {
                m.setDetails(XssDefencePolicy.defence(m.getDetails()));
            }

            // 1. 자재 먼저 DB에 등록 (MATERIAL_ID 확보)
            int result = materialService.materialInsert(m);

            if (result > 0) {
                // 2. 이미지가 있으면 디스크 저장 -> MATERIAL_FILES INSERT
                if (imageFile != null && !imageFile.isEmpty()) {
                    StoredFile storedFile = fileStore.store(imageFile, "material_upfiles");
                    MaterialFile materialFile = storedFile.toMaterialFile(m.getMaterialId());
                    materialService.materialFileInsert(materialFile);
                }

                session.setAttribute("alertMsg", "자재 등록이 완료되었습니다.");
                return "redirect:/admin/materials";
            } else {
                session.setAttribute("alertMsg", "자재 등록에 실패했습니다.");
                return "redirect:/admin/materials/new";
            }

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("alertMsg", "등록 중 오류가 발생했습니다.");
            return "redirect:/admin/materials/new";
        }
    }

    /**
     * 전체 목록 조회
     */
    @GetMapping("")
    public String selectMaterialList(Model model) {
        ArrayList<Material> list = materialService.selectMaterialList();
        model.addAttribute("materials", list);
        return "material/materialListHO";
    }

    /**
     * 상세 조회 (AJAX)
     */
    @GetMapping({"/detail", "detail"})
    @ResponseBody
    public Material materialDetail(@RequestParam("materialId") Long materialId) {
        return materialService.materialDetail(materialId);
    }

    /**
     * 수정 화면
     */
    @GetMapping("{materialId}/edit")
    public String materialEdit(@PathVariable("materialId") Long materialId, Model model) {
        Material material = materialService.materialDetail(materialId);
        model.addAttribute("material", material);
        return "material/materialEnrollForm";
    }

    /**
     * 자재 수정
     */
    @PostMapping("{materialId}")
    public String updateMaterial(
            @PathVariable(value = "materialId", required = false) Long pathMaterialId,
            @ModelAttribute Material m,
            @RequestParam(value = "materialImage", required = false) MultipartFile imageFile,
            Model model,
            HttpSession session) {

        Long finalMaterialId = (pathMaterialId != null) ? pathMaterialId : m.getMaterialId();
        if (finalMaterialId == null) {
            model.addAttribute("errorMsg", "수정할 자재의 식별 번호(ID)가 누락되었습니다.");
            return "common/errorPage";
        }
        m.setMaterialId(finalMaterialId);

        // XSS 방어
        if (m.getMaterialName() != null) {
            m.setMaterialName(XssDefencePolicy.defence(m.getMaterialName()));
        }
        if (m.getDetails() != null) {
            m.setDetails(XssDefencePolicy.defence(m.getDetails()));
        }

        if (imageFile != null && !imageFile.isEmpty()) {
            StoredFile storedFile = fileStore.store(imageFile, "material_upfiles");
            MaterialFile materialFile = storedFile.toMaterialFile(finalMaterialId);
            materialService.materialFileInsert(materialFile);
        }

        int result = materialService.updateMaterial(m);
        if (result > 0) {
        	session.setAttribute("alertMsg", "자재 정보 수정이 완료되었습니다.");
            return "redirect:/admin/materials";
        } else {
            model.addAttribute("errorMsg", "자재 정보 수정에 실패했습니다.");
            return "common/errorPage";
        }
    }

    /**
     * 자재 삭제 (INACTIVE 처리)
     */
    @PostMapping("{materialId}/status")
    public String deleteMaterial(@PathVariable("materialId") Long materialId, Model model, HttpSession session) {
        int result = materialService.deleteMaterial(materialId);
        if (result > 0) {
            session.setAttribute("alertMsg", "자재가 삭제되었습니다.");
            return "redirect:/admin/materials";
        } else {
            model.addAttribute("errorMsg", "자재 정보 삭제에 실패했습니다.");
            return "common/errorPage";
        }
    }
}
