package com.kh.burgerstack.common.pagination.model.dto;

import java.beans.ConstructorProperties;

import lombok.Getter;
import lombok.ToString;

/**
 * 클라이언트가 querystring으로 제공한 page와 size 값입니다.
 * 추가로 DB 조회를 위한 offset과 limit 값도 제공합니다.
 */
@Getter
@ToString
public class PagingRequest {
	private static final int DEFAULT_PAGE = 1;
	private static final int DEFAULT_SIZE = 10;
	private static final int MAX_SIZE = 100;

	private final int page; // 현재 페이지
	private final int size; // 페이지 크기(행 수)
	private final int offset; // DB 조회를 위한 offset
	private final int limit; // DB 조회를 위한 limit

	// Spring이 생성자로 파라미터를 바인딩하도록 매핑
	@ConstructorProperties({ "page", "size" })
	public PagingRequest(Integer page, Integer size) {
		this.page = normalizePage(page);
		this.size = normalizeSize(size);
		this.offset = (getPage() - 1) * getSize();
		this.limit = this.size;
	}

	private static int normalizePage(Integer page) {
		if (page == null || page < 1) {
			return DEFAULT_PAGE;
		}
		return page;
	}

	private static int normalizeSize(Integer size) {
		if (size == null || size < 1) {
			return DEFAULT_SIZE;
		}
		return Math.min(size, MAX_SIZE);
	}

	/**
	 * PageInfo를 생성합니다.<br>
	 * <br>
	 * 사용 방법:<br>
	 * ```<br>
	 * int totalCount = // DB에서 조회한 값<br>
	 * PageInfo pageInfo = PagingRequest.toPageInfo(totalCount);<br>
	 * ```<br>
	 *
	 * @param totalCount : 총 페이지 수(DB에서 COUNT로 조회)
	 * @return PageInfo : 생성된 PageInfo 객체
	 */
	public PageInfo toPageInfo(int totalCount) {
		return PageInfo.of(this, totalCount);
	}
}