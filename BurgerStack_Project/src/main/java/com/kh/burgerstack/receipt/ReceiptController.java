package com.kh.burgerstack.receipt;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.kh.burgerstack.common.pagination.PageInfo;
import com.kh.burgerstack.common.pagination.PagingRequest;

import jakarta.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("receipt")
public class ReceiptController {

	@Autowired
	private ReceiptService receiptService;

	@GetMapping("checkForm")
	public ModelAndView checkForm(ModelAndView mv) {

		// 우선 응답페이지를 만들어서 띄워보기
		mv.setViewName("receipt/receiptCheckForm");
		// > /WEB-INF/views/receipt/receiptForm.jsp

		return mv;
	}

	@GetMapping("history")
	public String history(PagingRequest pagingRequest, HttpServletRequest request, Model model) {
		PageInfo pageInfo = receiptService.getHistoryPageInfo(pagingRequest);

		if (pageInfo.isCurrentPageOutOfRange()) {
			return "redirect:receipt/receiptPlanList"
					+ pageInfo.getLastAvailablePageQueryString(request.getQueryString());
		}

		model.addAttribute("pageInfo", pageInfo);

		// 우선 응답페이지를 만들어서 띄워보기
		return "receipt/receiptHistoryList";
		// > /WEB-INF/views/receipt/receiptHistoryList.jsp
	}

	@GetMapping("historyDetail")
	public ModelAndView historyDetail(ModelAndView mv) {

		// 우선 응답페이지를 만들어서 띄워보기
		mv.setViewName("receipt/receiptHistoryDetail");
		// > /WEB-INF/views/receipt/receiptHistoryDetail.jsp

		return mv;
	}

	@GetMapping("planned")
	public String planned(PagingRequest pagingRequest, HttpServletRequest request, Model model) {
		PageInfo pageInfo = receiptService.getPlanPageInfo(pagingRequest);

		if (pageInfo.isCurrentPageOutOfRange()) {
			return "redirect:receipt/receiptPlanList"
					+ pageInfo.getLastAvailablePageQueryString(request.getQueryString());
		}

		model.addAttribute("pageInfo", pageInfo);

		// // > HashMap 이용해보기
		// HashMap<String, String> map = new HashMap<> ();
		// map.put("condition", condition);
		// map.put("keyword", keyword);

		// int searchCount = boardService.selectSearchCount(map);

		// // 위의 searchCount, currentPage, pageLimit, boardLimit 를 가지고
		// // maxPage, startPage, endPage 를 계산해서 구해야함!
		// // > 그리고 이걸 모두 Page info
		// PageInfo pi = Pagination.getPageInfo(searchCount, currentPage, pageLimit,
		// boardLimit);

		// // 위의 HashMap 과 PageInfo 둘 다 넘기면서 검색용 쿼리문을 실행해서 결과를 받아야함!
		// ArrayList<Receipt> list = receiptService.searchReceiptPlanList();
		// System.out.println(list);
		// for(Receipt r : list) {
		// System.out.println(r);
		// }

		// 우선 응답페이지를 만들어서 띄워보기
		return "receipt/receiptPlanList";
		// mv.setViewName("receipt/receiptPlanList");
		// > /WEB-INF/views/receipt/receiptPlanList.jsp

		// return mv;
	}

}
