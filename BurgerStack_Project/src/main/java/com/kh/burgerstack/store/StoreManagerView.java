package com.kh.burgerstack.store;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@ToString
public class StoreManagerView {

    private Long userId;
    private String loginId;
    private String userName;
    private String phone;
    private String email;
}
