package com.kh.burgerstack.material.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.burgerstack.common.template.XssDefencePolicy;
import com.kh.burgerstack.material.model.service.MaterialSerivce;
import com.kh.burgerstack.material.model.vo.Material;

@Controller
@RequestMapping("material")
public class MaterialController {

	@Autowired
	private MaterialSerivce materialSerivce;
	
	@GetMapping("enrollForm")
	public String materialEnrollform() {
		return "material/materialEnrollForm";
	} //materialEnrollForm
	
	@PostMapping("insert")
	public void materialInsert(Material m/*, @RequestParam(value = "materialImage", required = false) MultipartFile imageFile*/) {
		// System.out.println(m);
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
		
		// 2. 자재 코드 자동 생성
		// 방법 구상해보자. if 문 돌리기는 성능이 너무 저하된다..
		
		
		
		
		m.setMaterialCode("자동생성코드넣기");
		
		// 3. MaterialType 내용 변경
		switch(m.getMaterialType()) {
		
			/*
			냉장식품	RF (Refrigerated Food)
			냉동식품	FF (Frozen Food)
			상온식품	AF (Ambient Food)
			포장재	PK (Packaging)
			조리용품	KW (Kitchen Ware)
			기타		ET (Etcetera)
			*/
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
		
		// 4. XSS 공격 방지
		String replaceMaterialName = XssDefencePolicy.defence(m.getMaterialName());
		String replaceDetails = XssDefencePolicy.defence(m.getDetails());
		
		m.setMaterialName(replaceMaterialName);
		m.setDetails(replaceDetails);
		
		// 5. service 다녀오기
		int result = materialSerivce.materialInsert(m);
		
		// 6. 결과에 따른 메세지 출력
		if(result > 0) {
			// > 성공
		} else {
			// > 실패
		}
	} //materialInsert
	
}
