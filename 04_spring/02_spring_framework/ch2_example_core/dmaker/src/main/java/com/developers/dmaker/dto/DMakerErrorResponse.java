// 패키지 선언부이다. 'com.developers.dmaker.dto' 패키지에 속한 클래스임을 나타낸다.
package com.developers.dmaker.dto;

import com.developers.dmaker.code.DMakerErrorCode;
import lombok.*;

/**
 * DMakerErrorResponse 클래스는 DMaker 애플리케이션에서 발생한 오류에 대한 응답을 담는 DTO(Data Transfer Object) 클래스이다.
 * @Getter, @Setter: 각 필드에 대한 getter와 setter 메서드를 자동으로 생성한다.
 * @AllArgsConstructor: 모든 필드를 초기화하는 생성자를 자동으로 생성한다.
 * @NoArgsConstructor: 파라미터가 없는 기본 생성자를 자동으로 생성한다.
 * @Builder: 빌더 패턴을 구현하여 객체 생성 시 유연성을 제공한다.
 */
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class DMakerErrorResponse {
    // 오류 코드를 나타내는 필드이다. DMakerErrorCode 열거형 타입이다.
    private DMakerErrorCode errorCode;

    // 오류 메시지를 나타내는 필드이다.
    private String errorMessage;
}
