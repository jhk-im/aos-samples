// 패키지 선언부이다. 'com.developers.dmaker.service' 패키지에 속한 클래스임을 나타낸다.
package com.developers.dmaker.service;

import com.developers.dmaker.code.StatusCode;
import com.developers.dmaker.dto.CreateDeveloper;
import com.developers.dmaker.dto.DeveloperDetailDto;
import com.developers.dmaker.dto.DeveloperDto;
import com.developers.dmaker.dto.EditDeveloper;
import com.developers.dmaker.entity.Developer;
import com.developers.dmaker.entity.RetiredDeveloper;
import com.developers.dmaker.exception.DMakerException;
import com.developers.dmaker.repository.DeveloperRepository;
import com.developers.dmaker.repository.RetiredDeveloperRepository;
import com.developers.dmaker.type.DeveloperLevel;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

import static com.developers.dmaker.code.DMakerErrorCode.*;
import static com.developers.dmaker.constant.DMakerConstant.MAX_JUNIOR_EXPERIENCE_YEARS;
import static com.developers.dmaker.constant.DMakerConstant.MIN_SENIOR_EXPERIENCE_YEARS;

/**
 * DMakerService 클래스는 개발자 관련 비즈니스 로직을 처리하는 서비스 클래스이다.
 */
@Service
@RequiredArgsConstructor
public class DMakerService {
    // DeveloperRepository와 RetiredDeveloperRepository를 주입받는다.
    private final DeveloperRepository developerRepository;
    private final RetiredDeveloperRepository retiredDeveloperRepository;

    @Transactional
    public CreateDeveloper.Response createDeveloper(CreateDeveloper.Request request) {
        /*
        새로운 개발자를 생성하고 저장하는 작업을 트랜잭션으로 관리한다.
        모든 검증을 통과하고 나서 개발자를 생성 및 저장하는 작업이 하나의 트랜잭션으로 실행되어, 중간에 오류가 발생하면 롤백된다.
        **/
        validateCreateDeveloperRequest(request);

        // 요청을 바탕으로 Developer 엔티티를 생성한다.
        Developer developer = Developer.builder()
                .developerLevel(request.getDeveloperLevel())
                .developerSkillType(request.getDeveloperSkillType())
                .experienceYears(request.getExperienceYears())
                .memberId(request.getMemberId())
                .name(request.getName())
                .age(request.getAge())
                .build();
        // 생성된 Developer 엔티티를 저장소에 저장한다.
        developerRepository.save(developer);
        // 저장된 엔티티를 바탕으로 응답 객체를 생성하여 반환한다.
        return CreateDeveloper.Response.fromEntity(developer);
    }

    private void validateCreateDeveloperRequest(CreateDeveloper.Request request) {
        // 새로운 개발자 생성 요청을 검증하는 메서드이다.
        developerRepository.findByMemberId(request.getMemberId())
                .ifPresent((developer) -> {
                    /*
                    멤버 ID 중복 검사: 새로운 개발자를 생성할 때, 입력된 memberId가 이미 데이터베이스에 존재하는지 확인한다.
                    이 확인은 DeveloperRepository의 findByMemberId 메서드를 통해 수행되며, 이미 존재하는 경우 DMakerException을 던진다.
                    이는 중복된 멤버 ID가 존재하지 않도록 보장한다.
                    * */
                    throw new DMakerException(DUPLICATED_MEMBER_ID);
                });

        /*
        개발자 레벨과 경력 연수의 일관성 검사: 개발자의 레벨(DeveloperLevel)과 경력 연수(experienceYears)가 일치하는지 확인한다.
        예를 들어, 시니어(SENIOR) 레벨의 개발자는 최소 경력 연수(MIN_SENIOR_EXPERIENCE_YEARS)를 만족해야 하며,
        주니어(JUNIOR) 레벨의 개발자는 최대 경력 연수(MAX_JUNIOR_EXPERIENCE_YEARS)를 넘지 않아야 한다.
        이러한 조건을 만족하지 않으면 DMakerException을 던져 레벨과 경력 연수의 불일치를 방지한다.
        */
        if (request.getDeveloperLevel() == DeveloperLevel.SENIOR
                && request.getExperienceYears() < MIN_SENIOR_EXPERIENCE_YEARS) {
            throw new DMakerException(LEVEL_AND_EXPERIENCE_YEARS_NOT_MATCH);
        }

        if (request.getDeveloperLevel() == DeveloperLevel.JUNGNIOR
                && (request.getExperienceYears() > MIN_SENIOR_EXPERIENCE_YEARS
                || request.getExperienceYears() < MAX_JUNIOR_EXPERIENCE_YEARS)
        ) {
            throw new DMakerException(LEVEL_AND_EXPERIENCE_YEARS_NOT_MATCH);
        }

        if (request.getDeveloperLevel() == DeveloperLevel.JUNIOR
                && request.getExperienceYears() > MAX_JUNIOR_EXPERIENCE_YEARS) {
            throw new DMakerException(LEVEL_AND_EXPERIENCE_YEARS_NOT_MATCH);
        }
    }

    @Transactional
    public List<DeveloperDto> getAllEmployedDevelopers() {
        /*
        고용된 모든 개발자를 조회하는 작업을 트랜잭션으로 관리한다.
        데이터베이스에서 데이터를 읽어오는 작업이므로 일관된 상태를 유지하며 데이터를 반환한다.
        */
        return developerRepository.findDevelopersByStatusEquals(StatusCode.EMPLOYED)
                .stream().map(DeveloperDto::fromEntity)
                .collect(Collectors.toList());
    }

    @Transactional
    public DeveloperDetailDto getDeveloper(String memberId) {
        /*
        특정 멤버 ID에 해당하는 개발자 정보를 조회하는 작업을 트랜잭션으로 관리한다.
        데이터베이스에서 해당 개발자를 조회하고, 없으면 예외를 던진다.
        */
        return developerRepository.findByMemberId(memberId)
                .map(DeveloperDetailDto::fromEntity)
                .orElseThrow(
                        () -> new DMakerException(NO_DEVELOPER)
                );
    }

    @Transactional
    public DeveloperDetailDto editDeveloper(
            String memberId, EditDeveloper.Request request
    ) {
        /*
        특정 멤버 ID에 해당하는 개발자의 정보를 수정하는 작업을 트랜잭션으로 관리한다.
        개발자의 정보를 업데이트하는 작업이 하나의 트랜잭션으로 실행되어, 중간에 오류가 발생하면 롤백된다.
        */
        Developer developer = developerRepository.findByMemberId(memberId)
                .orElseThrow(
                        () -> new DMakerException(NO_DEVELOPER)
                );
        // 개발자 정보를 요청에 따라 수정한다.
        developer.setDeveloperLevel(request.getDeveloperLevel());
        developer.setDeveloperSkillType(request.getDeveloperSkillType());
        developer.setExperienceYears(request.getExperienceYears());
        developer.setName(request.getName());
        developer.setAge(request.getAge());

        return DeveloperDetailDto.fromEntity(developer);
    }

    @Transactional
    public DeveloperDetailDto deleteDeveloper(
            String memberId
    ) {
        /*
        특정 멤버 ID에 해당하는 개발자를 삭제(은퇴 처리)하는 작업을 트랜잭션으로 관리한다.
        개발자의 상태를 'RETIRED'로 변경하고, 은퇴한 개발자 정보를 저장하는 작업이 하나의 트랜잭션으로 실행된다.
        중간에 오류가 발생하면 롤백되어 데이터 일관성을 유지한다.
        */
        Developer developer = developerRepository.findByMemberId(memberId)
                .orElseThrow(
                        () -> new DMakerException(NO_DEVELOPER)
                );

        // 개발자의 상태를 'RETIRED'로 변경한다.
        developer.setStatus(StatusCode.RETIRED);

        // 은퇴한 개발자 정보를 RetiredDeveloper 엔티티로 생성하여 저장한다.
        RetiredDeveloper retiredDeveloper = RetiredDeveloper.builder()
                .memberId(developer.getMemberId())
                .name(developer.getName())
                .build();
        retiredDeveloperRepository.save(retiredDeveloper);
        return DeveloperDetailDto.fromEntity(developer);
    }
}
