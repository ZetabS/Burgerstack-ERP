package com.kh.burgerstack.common.helper;

import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.util.UriComponentsBuilder;

public class QueryStringUtils {
	private static final String[] queryParamsOrder = { "page", "size" };

	private QueryStringUtils() {
	}

	private static UriComponentsBuilder organize(UriComponentsBuilder builder) {
		MultiValueMap<String, String> params = builder.build().getQueryParams();
		MultiValueMap<String, String> orderedParams = new LinkedMultiValueMap<>();

		for (String key : queryParamsOrder) {
			if (params.containsKey(key)) {
				orderedParams.addAll(key, params.get(key));
			}
		}

		params.keySet().stream()
				.filter(key -> !orderedParams.containsKey(key))
				.sorted()
				.forEach(key -> orderedParams.addAll(key, params.get(key)));

		return builder.replaceQuery("")
				.queryParams(orderedParams);
	}

	private static UriComponentsBuilder getBuilderFromQueryString(String queryString) {
		UriComponentsBuilder builder = UriComponentsBuilder.newInstance();
		if (queryString != null && !queryString.isBlank()) {
			builder.query(queryString.replaceFirst("^\\?", ""));
		}
		return builder;
	}

	/**
	 * 쿼리스트링의 파라미터를 queryParamsOrder 순서대로 정리합니다.
	 *
	 * @param queryString
	 * @return
	 */
	public static String organize(String queryString) {
		UriComponentsBuilder builder = getBuilderFromQueryString(queryString);
		return organize(builder)
				.build()
				.toUriString();
	}

	/**
	 * 쿼리스트링의 특정 키의 값을 바꿉니다.
	 *
	 * @param queryString
	 * @param key
	 * @param value
	 * @return
	 */
	public static String replace(String queryString, String key, String value) {
		UriComponentsBuilder builder = getBuilderFromQueryString(queryString)
				.replaceQueryParam(key, value);
		return organize(builder)
				.build()
				.toUriString();
	}

	/**
	 * 쿼리스트링에 페이지네이션을 적용합니다.
	 *
	 * @param queryString
	 * @param page
	 * @param size
	 * @return
	 */
	public static String applyPagination(String queryString, int page, int size) {
		UriComponentsBuilder builder = getBuilderFromQueryString(queryString)
				.replaceQueryParam("page", page)
				.replaceQueryParam("size", size);
		return organize(builder)
				.build()
				.toUriString();
	}
}
