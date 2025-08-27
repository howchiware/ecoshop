package com.sp.app.service;

import java.security.SecureRandom;
import java.util.Map;
import java.util.Objects;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sp.app.mail.Mail;
import com.sp.app.mail.MailSender;
import com.sp.app.mapper.MemberMapper;
import com.sp.app.model.Member;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class MemberServiceImpl implements MemberService {

	private final MemberMapper mapper;
	private final MailSender mailSender;

	@Override
	public Member loginMember(Map<String, Object> map) {
		Member dto = null;

		try {
			dto = mapper.loginMember(map);
		} catch (Exception e) {
			log.info("loginMember: ", e);
		}

		return dto;
	}

	@Transactional(rollbackFor = { Exception.class })
	@Override
	public void insertMember(Member dto) throws Exception {
		try {
			long memberId = mapper.selectMemberId();
			dto.setMemberId(memberId);

			mapper.insertMember1(dto);

			mapper.insertMember2(dto);

		} catch (Exception e) {
			log.info("insertMember: ", e);
			throw e;
		}
	}

	@Override
	public Member findById(String userId) {

		Member dto = null;

		try {
			dto = Objects.requireNonNull(mapper.findById(userId));

		} catch (NullPointerException e) {
		} catch (Exception e) {
			log.info("findById : ", e);
		}

		return dto;
	}

	@Override
	public Member findByNickname(String nickname) {

		Member dto = null;

		try {
			dto = Objects.requireNonNull(mapper.findByNickname(nickname));

		} catch (NullPointerException e) {
		} catch (Exception e) {
			log.info("findByNickname : ", e);
		}

		return dto;
	}

	@Transactional(rollbackFor = { Exception.class })
	@Override
	public void updateMember(Member dto) throws Exception {

		try {
			mapper.updateMember1(dto);
			mapper.updateMember2(dto);
		} catch (Exception e) {
			log.info("updateMember : ", e);
			throw e;
		}

	}

	@Override
	public void deleteMember(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub

	}

	@Override
	public void generatePwd(Member dto) throws Exception {

		String lowercase = "abcdefghijklmnopqrstuvwxyz";
		String uppercase = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
		String digits = "0123456789";
		String special_characters = "!#@$%^&*()-_=+[]{}?";
		String all_characters = lowercase + digits + uppercase + special_characters;

		try {
			SecureRandom random = new SecureRandom();

			StringBuilder sb = new StringBuilder();

			sb.append(lowercase.charAt(random.nextInt(lowercase.length())));
			sb.append(uppercase.charAt(random.nextInt(uppercase.length())));
			sb.append(digits.charAt(random.nextInt(digits.length())));
			sb.append(special_characters.charAt(random.nextInt(special_characters.length())));

			for (int i = sb.length(); i < 10; i++) {
				int index = random.nextInt(all_characters.length());

				sb.append(all_characters.charAt(index));
			}

			StringBuilder password = new StringBuilder();
			while (sb.length() > 0) {
				int index = random.nextInt(sb.length());
				password.append(sb.charAt(index));
				sb.deleteCharAt(index);
			}

			String result;
			result = dto.getName() + "님의 새로 발급된 임시 패스워드는 <b> " + password.toString() + " </b> 입니다.<br>"
					+ "로그인 후 반드시 패스워드를 변경하시기 바랍니다.";

			Mail mail = new Mail();
			mail.setReceiverEmail(dto.getEmail());

			mail.setSenderEmail("ecomore@naver.com");
			mail.setSenderName("관리자");
			mail.setSubject("임시 패스워드 발급");
			mail.setContent(result);

			dto.setPassword(password.toString());
			mapper.updateMember1(dto);

			boolean b = mailSender.mailSend(mail);

			if (!b) {
				throw new Exception("이메일 전송중 오류가 발생했습니다.");
			}

		} catch (Exception e) {
			throw e;
		}
	}

	@Override
	public Member findByMemberId(long memberId) {
		Member dto = null;

		try {
			dto = Objects.requireNonNull(mapper.findByMemberId(memberId));

		} catch (NullPointerException e) {
		} catch (ArrayIndexOutOfBoundsException e) {
		} catch (Exception e) {
			log.info("findByMemberId : ", e);
		}

		return dto;
	}

}
