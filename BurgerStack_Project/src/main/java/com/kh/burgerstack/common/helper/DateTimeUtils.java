package com.kh.burgerstack.common.helper;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class DateTimeUtils {
	private static final DateTimeFormatter DATE_FORMATTER = DateTimeFormatter.ofPattern("yyyy-MM-dd");
	private static final DateTimeFormatter DATE_TIME_FORMATTER = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");

	private DateTimeUtils() {
	}

	public static String formatDate(LocalDate value) {
		return value == null ? "" : value.format(DATE_FORMATTER);
	}

	public static String formatDateTime(LocalDateTime value) {
		return value == null ? "" : value.format(DATE_TIME_FORMATTER);
	}
}
