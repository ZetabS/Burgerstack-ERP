package com.kh.burgerstack.common.template;

import org.jsoup.Jsoup;
import org.jsoup.safety.Safelist;

/**
 * ===== XSS 방어 관련 중요 안내 =====
content는 defence() 적용 제거, 허용 태그만 남기는 방식으로 교체
 *
 * Jsoup 라이브러리를 사용하는 화이트리스트 방식
 */
public class NoticeXssUtil {

    /**
     * Quill 에디터 HTML용 XSS 방어
     * 허용: 기본 텍스트 서식 태그 + img (Quill이 생성하는 태그들)
     * 차단: script, iframe, onerror 등 위험 속성
     */
    public static String cleanContent(String html) {
        if (html == null || html.trim().isEmpty()) return "";

        Safelist safelist = Safelist.relaxed()
            .addTags("s")                        // strike (취소선)
            .addAttributes("img", "src", "alt", "style")
            .addAttributes(":all", "class", "style");

        return Jsoup.clean(html, safelist);
    }
}

// ===== 컨트롤러에서 사용법 =====
// 기존:
//   n.setTitle(XssDefencePolicy.defence(n.getTitle()));
//   n.setContent(XssDefencePolicy.defence(n.getContent())); // ← 이게 문제!
//
// 수정:
//   n.setTitle(XssDefencePolicy.defence(n.getTitle()));          // 제목은 그대로
//   n.setContent(NoticeXssUtil.cleanContent(n.getContent()));    // 내용은 화이트리스트 방식
