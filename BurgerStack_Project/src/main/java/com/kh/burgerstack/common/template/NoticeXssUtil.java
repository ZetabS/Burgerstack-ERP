package com.kh.burgerstack.common.template;

import org.jsoup.Jsoup;
import org.jsoup.safety.Safelist;

public class NoticeXssUtil {

	public static String cleanContent(String html) {
	    if (html == null || html.trim().isEmpty()) return "";

	    // 1. img 태그 임시 치환 (Jsoup이 건드리지 못하게)
	    // src 속성을 임시 속성명으로 바꿔서 보호
	    String protected_html = html.replaceAll(
	        "<img([^>]*?)src=([\"'])(.*?)\\2([^>]*?)>",
	        "<img$1data-protected-src=$2$3$2$4>"
	    );

	    // 2. Jsoup XSS 정제
	    Safelist safelist = Safelist.relaxed()
	        .addTags("s")
	        .addAttributes("img", "data-protected-src", "alt", "style", "width", "height")
	        .addAttributes(":all", "class", "style");

	    String cleaned = Jsoup.clean(protected_html, safelist);

	    // 3. 임시 속성명을 다시 src로 복원
	    return cleaned.replaceAll("data-protected-src=", "src=");
	}
}