package edu.kh.jdbc.member.view;

import java.util.InputMismatchException;
import java.util.List;
import java.util.Scanner;

import edu.kh.jdbc.common.Session;
import edu.kh.jdbc.member.model.dto.Member;
import edu.kh.jdbc.member.model.service.MemberService;

/**
 * 회원 전용 화면
 * 
 * @author 정용화(이메일)
 *
 */
public class MemberView {

	private Scanner sc = new Scanner(System.in);

	private MemberService service = new MemberService();

	/**
	 * 회원 기능 메뉴
	 */
	public void memberMenu() {
		int input = 0;

		do {
			try {
				System.out.println("\n======회원기능 ==========\n");
				System.out.println("1. 내 정보 조회");
				System.out.println("2. 회원 목록 조회(아이디, 이름, 성별)");
				System.out.println("3. 내 정보 수정 (이름, 성별)");
				System.out.println("4. 비밀번호 변경(현재 비밀번호, 새 비밀번호, 새 비밀번호 확인)");
				System.out.println("5. 회원 탈퇴(보안코드,비밀번호, UPDATE)");

				System.out.println("9. 메인 메뉴로 돌아가기");
				System.out.println("0. 프로그램 종료");

				System.out.println("\n 메뉴 선택 :");
				input = sc.nextInt();
				sc.nextLine();
				switch (input) {
				case 1:
					selectMyInfo();
					break;
				case 2:
					selectMemberList(); break;
				case 3:
					break;
				case 4:
					break;
				case 5:
					break;
				case 9:
					System.out.println("\n====메인 메뉴로 돌아갑니다 ======\n");
					break;
				case 0:
					System.out.println("\n===프로그램 종료===== \n");
					// JVM 강제 종료 구문
					// 매개변수는 기본 0, 다른 숫자는 오류를 의미
					System.exit(0);

				default:
					System.out.println("\n*** 메뉴 번호만 입력 해주세요 ***\n");
				}

			} catch (InputMismatchException e) {
				System.out.println("\n*** 입력 형식이 올바르지 않습니다***\n");
				sc.nextLine(); // 입력버퍼에 잘못된 문자열 제거
				input = -1; // while문 종료 방지
			}
		} while (input != 0);
	}
	/**
	 * 내 정보 조회
	 */
	private void selectMyInfo() {
		System.out.println("\n=============내 정보 조회===============\n");
		
		//회원 번호, 아이디, 이름, 성별(남/여), 가입일
		// Session.loginMemver 이용
		
		System.out.println("회원 번호 : " + Session.loginMember.getMemberNo());
		System.out.println("아이디 : " + Session.loginMember.getMemeberId());
		System.out.println("이름 : " + Session.loginMember.getMemeberName());
		
		if(Session.loginMember.getMemeberGender().equals("M")) {
			System.out.println("성별 : 남");
		}else {
			System.out.println("성별 : 여");
		}
		System.out.println(" 가입일 : "+Session.loginMember.getEnrollDate());
	}
	private void selectMemberList() {
		System.out.println("\n=============회원 목록 저회============\n");
		try {
			//회원 목록 조회 서비스 호출 후 결과 반환 받기
			List<Member> memberList = service.selectMemberList();
			if(memberList.isEmpty()) {
				System.out.println("\n======조회 결과가 없습니다 =========\n");
				return;
			}
			
			// 1 user04 유점사 남
			// 2 user03 유점삼 남
			// 3 user02 유점이 남
			// 4 user01 유점일 남
			
			for(int i=0; i<memberList.size(); i++){
				System.out.printf("%d\t%s\t%s\t%s \n",
						i+1, 
						memberList.get(i).getMemeberId(),
						memberList.get(i).getMemeberName(),
					    memberList.get(i).getMemeberGender());
			}
			
		} catch (Exception e) {
			System.out.println("\n*******회원 목록 조회 중 예외 발생*************");
			e.printStackTrace();
		}
	}
}
