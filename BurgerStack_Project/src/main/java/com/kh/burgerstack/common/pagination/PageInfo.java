package com.kh.burgerstack.common.pagination;

import com.kh.burgerstack.common.helper.QueryStringUtils;

import lombok.Getter;
import lombok.ToString;

/**
 * 페이지네이션 기능 구현을 위한 값을 계산합니다.<br>
 * JSP의 pagination tag에서 사용합니다.<br>
 * <br>
 * 생성자로 직접 만들 수 없습니다.<br>
 * PageRequest.toPageInfo()를 사용하세요.
 */
@Getter
@ToString
public class PageInfo {
	private static final int BLOCK_SIZE = 10; // 블록 크기, 페이지네이션 바에서 보이는 총 페이지 개수

	private final int currentPage; // 현재 페이지
	private final int pageSize; // 페이지 크기(행 개수)
	private final int totalCount; // 전체 행 수
	private final int totalPages; // 전체 페이지 수

	private final int startPage; // 블록의 첫 페이지
	private final int endPage; // 블록의 마지막 페이지
	private final int previousPage; // 블록의 이전 페이지
	private final int nextPage; // 블록의 다음 메이지
	private final boolean hasPrevious; // 이전 페이지 존재 여부
	private final boolean hasNext; // 다음 페이지 존재 여부

	private PageInfo(int currentPage, int pageSize, int totalCount) {
		this.currentPage = currentPage;
		this.pageSize = pageSize;
		this.totalCount = totalCount;

		int blockOffset = (int) ((BLOCK_SIZE - 1) / 2);
		this.totalPages = (totalCount + pageSize - 1) / pageSize;

		this.startPage = Math.max(currentPage - blockOffset - 1, 1);
		this.endPage = Math.min(Math.max(startPage + BLOCK_SIZE - 1, currentPage + blockOffset), totalPages);

		this.hasPrevious = startPage > 1;
		this.hasNext = endPage < totalPages;
		this.previousPage = startPage - 1;
		this.nextPage = endPage + 1;
	}

	/**
	 * PagingRequest에서 PageInfo를 생성합니다.<br>
	 * <br>
	 * 사용 방법:<br>
	 * ```<br>
	 * int totalCount = // DB에서 조회한 값<br>
	 * PageInfo pageInfo = PageInfo.of(pagingRequest, totalCount);<br>
	 * ```<br>
	 *
	 * @param request    : PagingRequest 객체
	 * @param totalCount : 총 페이지 수(DB에서 COUNT로 조회)
	 * @return PageInfo : 생성된 PageInfo 객체
	 */
	public static PageInfo of(PagingRequest request, int totalCount) {
		int currentPage = request.getPage();
		int pageSize = request.getSize();
		return new PageInfo(currentPage, pageSize, totalCount);
	}

	/**
	 * 페이지 범위가 초과되었는지 확인합니다.
	 *
	 * @return 초과했다면 true, 아니면 false
	 */
	public boolean isCurrentPageOutOfRange() {
		return totalPages > 0 && currentPage > totalPages;
	}

	/**
	 * 조회할 수 있는 마지막 페이지를 반환합니다.
	 *
	 * @return 마지막 페이지
	 */
	public int getLastAvailablePage() {
		return Math.max(totalPages, 1);
	}

	/**
	 * 조회할 수 있는 마지막 페이지로 리다이렉트하기 위한 쿼리스트링을 반환합니다.<br>
	 * HttpServletRequest의 request.getQueryString()으로 현재 쿼리스트링을 얻을 수 있습니다.
	 *
	 * @param queryString : 현재 쿼리스트링
	 * @return 리다이렉트할 새 querystring
	 */
	public String getLastAvailablePageQueryString(String queryString) {
		return QueryStringUtils.applyPagination(queryString, getLastAvailablePage(), pageSize);
	}
}