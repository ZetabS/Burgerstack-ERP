package com.kh.burgerstack.material;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.burgerstack.common.template.XssDefencePolicy;

@Controller
@RequestMapping({ "/owner/materials", "/admin/materials" })
public class MaterialController {

	@Autowired
	private MaterialSerivce materialSerivce;
	
	@GetMapping("new")
	public String materialEnrollform() {
		return "material/materialEnrollForm";
	} //materialEnrollForm
	
	@PostMapping("")
	public String materialInsert(Material m/*, @RequestParam(value = "materialImage", required = false) MultipartFile imageFile*/) {
		 System.out.println("### 컨트롤러 진입 : " + m);
		// System.out.println(imageFile);
		
		// 1. 파일명 변경 후 DB 저장
		// 파일 java 완성 후 구문 활성화 및 완성하기
		/*
		System.out.println(imageFile);
		if (imageFile != null && !imageFile.isEmpty()) {
	        String originalFilename = imageFile.getOriginalFilename();
	        long fileSize = imageFile.getSize();
	    }
		*/
		
		
		// 3. MaterialType 내용 변경
		
		
		// 4. XSS 공격 방지
		String replaceMaterialName = XssDefencePolicy.defence(m.getMaterialName());
		String replaceDetails = XssDefencePolicy.defence(m.getDetails());
		
		m.setMaterialName(replaceMaterialName);
		m.setDetails(replaceDetails);
		
		// 5. service 다녀오기
		int result = materialSerivce.materialInsert(m);
		System.out.println("### insert 결과 : " + result);
		// 6. 결과에 따른 메세지 출력
		if(result > 0) {
			// > 성공
			return "redirect:/admin/materials";
		} else {
			// > 실패
			return "common/errorPage";
		}
	} //materialInsert
	
	public void selectAll() {
		/*
		switch(m.getMaterialType()) {
		
			냉장식품	RF (Refrigerated Food)
			냉동식품	FF (Frozen Food)
			상온식품	AF (Ambient Food)
			포장재	PK (Packaging)
			조리용품	KW (Kitchen Ware)
			기타		ET (Etcetera)
			
			case "RF" :
				m.setMaterialType("냉장식품");
				break;
			case "FF" :
				m.setMaterialType("냉동식품");
				break;
			case "AF" :
				m.setMaterialType("상온식품");
				break;
			case "PK" :
				m.setMaterialType("포장재");
				break;
			case "KW" :
				m.setMaterialType("주방용품");
				break;
			case "ET" :
				m.setMaterialType("기타");
				break;
		}
		*/
	}
}
