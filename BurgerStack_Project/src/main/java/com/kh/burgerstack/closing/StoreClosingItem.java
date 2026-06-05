package com.kh.burgerstack.closing;

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
public class StoreClosingItem {
    private Long storeClosingItemId;
    private Long systemQuantity;
    private Long physicalQuantity;
    private Long disposalQuantity;
    private String closingItemMemo;
    private String materialNameSnapshot;
    private Long storeClosingId;
    private Long storeInventoryId;
}
