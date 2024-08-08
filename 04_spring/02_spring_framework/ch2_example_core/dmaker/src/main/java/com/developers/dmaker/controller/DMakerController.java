// 패키지 선언부이다. 'com.developers.dmaker.controller' 패키지에 속한 클래스임을 나타낸다.
package com.developers.dmaker.controller;

import com.developers.dmaker.dto.CreateDeveloper;
import com.developers.dmaker.dto.DeveloperDetailDto;
import com.developers.dmaker.dto.DeveloperDto;
import com.developers.dmaker.dto.EditDeveloper;
import com.developers.dmaker.service.DMakerService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.List;

/**
 * DMakerController 클래스는 개발자 관련 요청을 처리하는 REST API 컨트롤러이다.
 * @RestController 애너테이션을 사용하여 RESTful 웹 서비스를 구현한다.
 * @Slf4j 애너테이션을 사용하여 로깅 기능을 제공한다.
 * @RequiredArgsConstructor 애너테이션을 사용하여 final 필드에 대한 생성자를 자동으로 생성한다.
 */
@Slf4j
@RestController
@RequiredArgsConstructor
public class DMakerController {

    // DMakerService를 주입받는다. 이를 통해 비즈니스 로직을 처리한다.
    private final DMakerService dMakerService;

    // 새로운 개발자를 생성하는 API 엔드포인트이다.
    // @Valid 애너테이션을 사용하여 요청의 유효성을 검사한다.
    // @RequestBody 애너테이션을 사용하여 요청 본문에서 데이터를 추출한다.
    @PostMapping("/create-developer")
    public ResponseEntity<CreateDeveloper.Response> createDeveloper(
            @Valid @RequestBody CreateDeveloper.Request request
    ) {
        // dMakerService.createDeveloper(request)를 호출하여 개발자를 생성하고, 결과를 반환한다.
        return ResponseEntity.ok(
                dMakerService.createDeveloper(request)
        );
    }

    // 모든 고용된 개발자 목록을 조회하는 API 엔드포인트이다.
    @GetMapping("/developers")
    public ResponseEntity<List<DeveloperDto>> getDevelopers() {
        // dMakerService.getAllEmployedDevelopers()를 호출하여 개발자 목록을 조회하고, 결과를 반환한다.
        return ResponseEntity.ok(
                dMakerService.getAllEmployedDevelopers()
        );
    }

    // 특정 멤버 ID에 해당하는 개발자 정보를 조회하는 API 엔드포인트이다.
    // @PathVariable 애너테이션을 사용하여 URL 경로 변수에서 memberId를 추출한다.
    @GetMapping("/developer/{memberId}")
    public ResponseEntity<DeveloperDetailDto> getDeveloper(
            @PathVariable String memberId
    ) {
        // dMakerService.getDeveloper(memberId)를 호출하여 개발자 정보를 조회하고, 결과를 반환한다.
        return ResponseEntity.ok(
                dMakerService.getDeveloper(memberId)
        );
    }

    // 특정 멤버 ID에 해당하는 개발자 정보를 수정하는 API 엔드포인트이다.
    // @PathVariable 애너테이션을 사용하여 URL 경로 변수에서 memberId를 추출한다.
    // @Valid 애너테이션을 사용하여 요청의 유효성을 검사한다.
    // @RequestBody 애너테이션을 사용하여 요청 본문에서 데이터를 추출한다.
    @PutMapping("/developer/{memberId}")
    public ResponseEntity<DeveloperDetailDto> updateDeveloper(
            @PathVariable String memberId,
            @Valid @RequestBody EditDeveloper.Request request
    ) {
        // dMakerService.editDeveloper(memberId, request)를 호출하여 개발자 정보를 수정하고, 결과를 반환한다.
        return ResponseEntity.ok(
                dMakerService.editDeveloper(memberId, request)
        );
    }

    // 특정 멤버 ID에 해당하는 개발자를 삭제(은퇴 처리)하는 API 엔드포인트이다.
    // @PathVariable 애너테이션을 사용하여 URL 경로 변수에서 memberId를 추출한다.
    @DeleteMapping("/developer/{memberId}")
    public ResponseEntity<DeveloperDetailDto> deleteDeveloper(
            @PathVariable String memberId
    ) {
        // dMakerService.deleteDeveloper(memberId)를 호출하여 개발자를 삭제하고, 결과를 반환한다.
        return ResponseEntity.ok(
                dMakerService.deleteDeveloper(memberId)
        );
    }
}

/*
DMakerService
- 비즈니스 로직을 처리하는 서비스 클래스이다.
- 이 필드는 생성자 주입을 통해 초기화된다.

createDeveloper
- 새로운 개발자를 생성하는 POST 요청을 처리한다.
- 요청 본문에서 CreateDeveloper.Request 객체를 받아 유효성을 검사한다.
- dMakerService.createDeveloper 메서드를 호출하여 개발자를 생성한 후 결과를 반환한다.

getDevelopers
- 모든 고용된 개발자 목록을 조회하는 GET 요청을 처리한다.
- dMakerService.getAllEmployedDevelopers 메서드를 호출하여 개발자 목록을 조회한 후 결과를 반환한다.

getDeveloper
- 특정 멤버 ID에 해당하는 개발자 정보를 조회하는 GET 요청을 처리한다.
- URL 경로 변수에서 memberId를 추출하고, dMakerService.getDeveloper 메서드를 호출하여 개발자 정보를 조회한 후 결과를 반환한다.

updateDeveloper
- 특정 멤버 ID에 해당하는 개발자 정보를 수정하는 PUT 요청을 처리한다.
- URL 경로 변수에서 memberId를 추출한다.
- 요청 본문에서 EditDeveloper.Request 객체를 받아 유효성을 검사한다.
- dMakerService.editDeveloper 메서드를 호출하여 개발자 정보를 수정한 후 결과를 반환한다.

deleteDeveloper
- 특정 멤버 ID에 해당하는 개발자를 삭제(은퇴 처리)하는 DELETE 요청을 처리한다.
- URL 경로 변수에서 memberId를 추출한다.
- dMakerService.deleteDeveloper 메서드를 호출하여 개발자를 삭제한 후 결과를 반환한다.
*/